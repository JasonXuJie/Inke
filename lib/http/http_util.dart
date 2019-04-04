import 'dart:async';
import 'package:http/http.dart' as http;

class HttpUtil{
  //get
  static Future<String> get(String url,{Map<String,String> params})async{
    if(params !=null && params.isNotEmpty){
      StringBuffer stringBuffer = StringBuffer('?');
      params.forEach((key,value){
        stringBuffer.write('$key'+'='+'$value'+'&');
      });
      String paramStr = stringBuffer.toString();
      paramStr = paramStr.substring(0,paramStr.length-1);
      url+=paramStr;
    }
    print(url);
    http.Response response = await http.get(url);
    return response.body;
  }


  //post
  static Future<String> post(String url,{Map<String,String> params}) async{
    http.Response response = await http.post(url,body: params);
    return response.body;
  }
}