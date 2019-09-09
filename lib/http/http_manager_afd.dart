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
      baseUrl: ApiService.afandaBaseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      //headers:
    );
    _dio = Dio(option);
    if (AppConfig.debug) {
      _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启日志
    }
  }

   get(url, {Map<String, dynamic> params}) async {
    _dio.options.method = 'GET';
    Response response;
    try {
      response = await _dio.request(url, queryParameters: params);
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
      response = await _dio.request(url, data: params);
      return response.data;
    } on DioError catch (e) {
      print('答应数据：${e.error}');
      print('打印数据：${e.request}');
      print('打印数据:${e.message}');
    }
  }
}
