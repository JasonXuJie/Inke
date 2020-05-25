import 'dart:core';
import 'package:Inke/util/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'http_error.dart';
import 'package:Inke/config/config.dart';

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);

///失败回调
typedef HttpFailureCallback<T> = void Function(HttpError data);

///数据解析回调
typedef T JsonParse<T>(dynamic data);


///@desc 封装http请求
///@author Jason
class HttpClient{
  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String,CancelToken> _cancelTokens = Map<String,CancelToken>();
  
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  ///http request method
  static const String GET = 'get';
  static const String POST = 'post';

  ///成功
  static const num SUCCESS = 200;

  Dio _client;

  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  ///创建dio实例对象
  HttpClient._internal(){
    if(_client == null){
        /// 全局属性：请求前缀、连接超时时间、响应超时时间
        BaseOptions options = BaseOptions(
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT
        );
        _client = Dio(options);
        ///添加httpLog
        if(Config.isShowLog){
          _client.interceptors.add(LogInterceptor(responseBody: true,requestHeader: false,responseHeader: false,request: false));
        }
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init({
    String baseUrl,
    int connectTimeOut,
    int receiveTimeout,
    List<Interceptor> interceptors
  }){
    _client.options = _client.options.merge(
      baseUrl: baseUrl,
      connectTimeout: connectTimeOut,
      receiveTimeout: receiveTimeout  
    );
    if(interceptors != null && interceptors.isNotEmpty){
      _client.interceptors.addAll(interceptors);
    }
  }


  ///Get请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void get({
    @required String url,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    @required String tag,
  })async{
     _request(
       url: url, 
       params: params,
       method: GET,
       successCallback: successCallback,
       failureCallback: failureCallback,
       tag: tag);
  }


  ///post网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void post({
    @required String url,
    data,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    @required String tag,
  })async{
    _request(
      url: url,
      data: data,
      method: POST,
      params: params,
      successCallback: successCallback,
      failureCallback: failureCallback, 
      tag: tag
    );
  }
  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void _request({
    @required String url,
    String method,
    data,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    @required String tag,
  })async{
    ///检查网络是否连接
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      if(failureCallback != null){
        failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
      }
      print('请求网络异常，请稍后重试！');
      return ;
    }
    ///设置默认值
    params = params ?? {};
    method = method ?? 'GET';
    options?.method = method;
    options = options??Options(
      method:method,
    );
    //url = _restfulUrl(url, params);
    try {
       CancelToken cancelToken;
       if(tag != null){
         cancelToken = _cancelTokens[tag] == null?CancelToken():_cancelTokens[tag];
         _cancelTokens[tag] = cancelToken;
       }
       Response<Map<String,dynamic>> response = await _client.request(url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken
       );
       if(response.statusCode == SUCCESS){
         ///成功
         if(successCallback != null){
            successCallback(response.data);
         }
       }else{
         ///失败
         print("请求服务器出错");
         Toast.show('请求服务器出错');
         if(failureCallback != null){
           failureCallback(HttpError(HttpError.FAILED, '请求服务器出错'));
         }
       }
    }on DioError catch(e,s){
      print("请求出错：$e\n$s");
      Toast.show("请求出错：$e\n$s");
      if(failureCallback != null && e.type != DioErrorType.CANCEL){
        failureCallback(HttpError.dioError(e));
      }
    } catch (e,s) {
       print("未知异常出错：$e\n$s");
       Toast.show("未知异常出错：$e\n$s");
       if(failureCallback != null){
         failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
       }
    }
  }


  ///下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  进度
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void download({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String,dynamic> params,
    data,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    @required String tag
  })async{
     //检查网络是否连接
     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
     if(connectivityResult == ConnectivityResult.none){
       if(failureCallback != null){
         failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
       }
      print("请求网络异常，请稍后重试！");
      return;
     }
    ////0代表不设置超时
    int receiveTimeout = 0;
    options ??= options == null?Options(
      receiveTimeout: receiveTimeout
    ):options.merge(receiveTimeout: receiveTimeout);
    //设置默认值
    params = params ?? {};
    //url = _restfulUrl(url, params);
    try {
      CancelToken cancelToken;
      if(tag != null){
        cancelToken = _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response response = await _client.download(url, savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: params,
        data: data,
        options: options,
        cancelToken: cancelToken
      );
      if(successCallback != null){
        successCallback(response.data);
      }
    } on DioError catch(e,s){
       print("请求出错：$e\n$s");
       Toast.show("请求出错：$e\n$s");
       if(failureCallback !=null && e.type != DioErrorType.CANCEL){
         failureCallback(HttpError.dioError(e));
       }
    }catch (e,s) {
        print("未知异常出错：$e\n$s");
        Toast.show("未知异常出错：$e\n$s");
        if(failureCallback != null){
          failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
        }
    }  
  }


  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void upload({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    @required String tag
  })async{
    //检查网络是否连接
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      if(failureCallback !=null){
        failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
      }
      print("请求网络异常，请稍后重试！");
      return;
    }
    //设置默认值
    params = params ?? {};
    //强制POST请求
    options?.method = POST;
    options = options ?? Options(
        method: POST,
    );
    //url = _restfulUrl(url, params);
    try {
       CancelToken cancelToken;
       if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      if (response.statusCode == SUCCESS) {
        //成功
        if (successCallback != null) {
          successCallback(response.data);
        }
      } else {
        //失败
        print("请求服务器出错");
        if (failureCallback != null) {
          failureCallback(HttpError(HttpError.FAILED, '请求服务器出错'));
        }
      }
    } on DioError catch(e,s){
       print("请求出错：$e\n$s");
      if (failureCallback != null && e.type != DioErrorType.CANCEL) {
        failureCallback(HttpError.dioError(e));
      }
    } catch (e,s) {
       print("未知异常出错：$e\n$s");
      if (failureCallback != null) {
         failureCallback(HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
      }
    }
  }

  ///GET异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> getAsync<T>({
    @required String url,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  })async{
    return _requestAsync(
      url: url, 
      method: GET,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag);
  }


  ///POST 异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> postAsync<T>({
    @required String url,
    data,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  })async{
    return _requestAsync(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
      jsonParse: jsonParse, 
      tag: tag
      );  
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> _requestAsync<T>({
    @required String url,
    String method,
    data,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  })async{
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
    }
     //设置默认值
    params = params ?? {};
    method = method ?? 'GET';
    options?.method = method;
    options = options ??
        Options(
          method: method,
        );
    //url = _restfulUrl(url, params);
    try {
       CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String, dynamic>> response = await _client.request(url,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
      if(response.statusCode == SUCCESS){
        //成功
        if(jsonParse != null){
          return jsonParse(response.data);
        }
      }else{
        //失败
        //只能用 Future，外层有 try catch
        Toast.show('请求服务器出错');
        return Future.error((HttpError(HttpError.FAILED, '请求服务器出错')));
      }
    }on DioError catch(e,s){
      print("请求出错：$e\n$s");
      Toast.show("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e,s) {
      print("未知异常出错：$e\n$s");
      Toast.show("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
    }    
  }


  ///异步下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> downLoadAsync({
    @required String url,
    @required String savePath,
    ProgressCallback onReceiveProgress,
    Map<String,dynamic> params,
    data,
    Options options,
    @required String tag,
  }) async{
     //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
    }
    //设置下载不超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);
     //设置默认值
    params = params ?? {};
    //url = _restfulUrl(url, params);
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      return _client.download(
        url, 
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: params,
        data: data,
        options: options,
        cancelToken: cancelToken
      );
    }on DioError catch(e,s){
      print("请求出错：$e\n$s");
      Toast.show("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e,s) {
      print("未知异常出错：$e\n$s");
      Toast.show("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }    
  }


  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> uploadAsync<T>({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  })async{
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
    }
    //设置默认值
    params = params ?? {};
    //强制 POST 请求
    options?.method = POST;
    options = options ??
        Options(
          method: POST,
        );

    //url = _restfulUrl(url, params);
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
       if (response.statusCode == SUCCESS) {
        //成功
        if (jsonParse != null) {
          return jsonParse(response.data);
        }
      } else {
        //失败
        Toast.show('请求服务器出错');
        return Future.error((HttpError(HttpError.FAILED, '请求服务器出错')));
      }    
    } on DioError catch(e,s){
      print("请求出错：$e\n$s");
      Toast.show("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    }catch (e,s) {
      print("未知异常出错：$e\n$s");
      Toast.show("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.FAILED, "网络异常，请稍后重试！"));
    }
  }


  ///取消网络请求
  void cancel(String tag){
    if(_cancelTokens.containsKey(tag)){
      if(!_cancelTokens[tag].isCancelled){
         _cancelTokens[tag].cancel(); 
      }
      _cancelTokens.remove(tag);
    }
  }

  ///restful处理
  String _restfulUrl(String url,Map<String,dynamic> params){
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key,value){
        if(url.indexOf(key) != -1){
          url = url.replaceAll(':$key', value.toString());
        } 
    });
    return url;
  }
}