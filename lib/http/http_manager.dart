import 'package:dio/dio.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/http/api.dart';

class HttpManager {
  static var httpManager;
  static Dio _dio;

  static HttpManager getInstance() {
    if (httpManager == null) {
      httpManager = HttpManager();
    }
    return httpManager;
  }

  HttpManager() {
    var option = BaseOptions(
      baseUrl: Api.doubanBaseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      //headers:
    );
    _dio = Dio(option);
    if (AppConfig.debug) {
      _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启日志
    }
  }

   get(url, {Map<String, String> params}) async {
    _dio.options.method = 'GET';
    Response response;
    try {
      response = await _dio.get(url, queryParameters: params);
      return response.data;
    } on DioError catch (e) {
      print('答应数据：${e.error}');
      print('打印数据：${e.request}');
      print('打印数据:${e.message}');
    }
  }

   post(url, params) async {
    _dio.options.method = 'POST';
    Response response;
    try {
      response = await _dio.post(url, data: params);
      return response.data;
    } on DioError catch (e) {
      print('答应数据：${e.error}');
      print('打印数据：${e.request}');
      print('打印数据:${e.message}');
    }
  }

}
