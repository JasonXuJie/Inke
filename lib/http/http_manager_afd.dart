import 'package:dio/dio.dart';
import 'package:Inke/http/api.dart';

class AfdHttpManager {
  static var httpManager;
  static Dio _dio;

  static AfdHttpManager getInstance() {
    if (httpManager == null) {
      httpManager = AfdHttpManager();
    }
    return httpManager;
  }

  AfdHttpManager() {
    var option = BaseOptions(
      baseUrl: Api.afandaBaseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      //headers:
    );
    _dio = Dio(option);
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启日志
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
