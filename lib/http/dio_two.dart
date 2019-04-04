import 'package:dio/dio.dart';
import 'package:Inke/config/app_config.dart';
class DioUtil {

//  static get(baseUrl,url,{Map<String, String> params}) async {
//    return await request('GET', baseUrl, url, params);
//  }
//
//  static post(url, baseUrl, params) async {
//    return await request('POST', baseUrl, url, params);
//  }
//
//  static request(method, baseUrl, url, params) async {
//    var option = BaseOptions(
//      method: method,
//      baseUrl: baseUrl,
//      connectTimeout: 30000,
//      receiveTimeout: 3000,
//      //headers:
//    );
//    var dio = Dio(option);
//    if(AppConfig.debug){
//      dio.interceptors.add(LogInterceptor(responseBody: true)); //开启日志
//    }
//    Response response;
//    try {
//      response = await dio.request(url, data: params);
//      return response.data;
//    } on DioError catch (e) {
//      print('答应数据：${e.error}');
//      print('打印数据：${e.request}');
//      print('打印数据:${e.message}');
//    }
//  }
}
