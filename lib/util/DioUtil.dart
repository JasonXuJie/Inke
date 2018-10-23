import 'package:dio/dio.dart';
import '../Api.dart';

class DioUtil{

  static DioUtil _instance;//豆瓣
  static DioUtil _jhInstance;//聚合数据
  static DioUtil _afdInstance;
  Dio dio;
  CancelToken cancelToken;


  static DioUtil getInstance(){
    if(_instance == null){
      _instance = DioUtil('douban');
    }
    return _instance;
  }

  static DioUtil getJhInstance(){
    if(_jhInstance == null){
      _jhInstance = DioUtil('juhe');
    }
    return _jhInstance;
  }

  static DioUtil getAfdInstance(){
    if(_afdInstance == null){
      _afdInstance = DioUtil('afd');
    }
    return _afdInstance;
  }



  DioUtil(tag){
    var baseUrl;
    if(tag=='douban'){
      baseUrl = ApiService.DOUBAN_BASE_URL;
    }else if(tag=='juhe'){
      baseUrl = ApiService.JUHE_BASE_URL;
    }else if(tag == 'afd'){
      baseUrl = ApiService.AFANDA_BASE_URL;
    }
    Options options = Options(
      baseUrl:baseUrl,
      connectTimeout: 60000,//连接服务器超时时间，单位是毫秒.
      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      //receiveTimeout: 10000,
    );
    dio = new Dio(options);
    cancelToken = CancelToken();
  }






  get(url,{data})async{
    Response response;
    try{
      if(data!=null){
        response = await dio.get(
          url,
          data: data,
          cancelToken: cancelToken,
        );
      }else{
        response = await dio.get(
          url,
          cancelToken: cancelToken,
        );
      }
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('请求取消');
      }else{
        print('请求发生错误${e.toString()}');
      }
    }
    return response.data;
  }



  post(url,data)async{
    Response response;
    try{
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('请求取消');
      }else{
        print('请求发生错误${e.toString()}');
      }

    }
    return response.data;
  }


  download(urlPath,savePath){
    Response response;
    try{
      dio.download(urlPath, savePath);
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('请求取消');
      }else{
        print('请求发生错误');
      }
    }
   return response.data;
  }


  cancel(){
    cancelToken.cancel('cancel');
  }


}