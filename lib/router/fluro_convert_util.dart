import 'dart:convert';

///fluro编码解码工具
class FluroConvertUtil{

  ///fluro传递中文参数前，先转换，fluro不支持中文传递
  static String fluroCnParamsEncode(String originalCn){
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  ///fluro传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn){
    var list = List<int>();
    ///字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  ///String转int
  static int str2int(String str){
    return int.parse(str);
  }

  ///string转double
  static double str2double(String str){
    return double.parse(str);
  }

  ///string转bool
  static bool str2bool(String str){
    if(str == 'true'){
      return true;
    }else{
      return false;
    }
  }


  static String bool2Str(bool flag){
    return '$flag';
  }

  ///object转string json
  static obj2str<T>(T t){
    return fluroCnParamsEncode(jsonEncode(t));
  }

  ///string json转map
  static Map<String,dynamic> str2map(String str){
    return json.decode(fluroCnParamsDecode(str));
  }


}