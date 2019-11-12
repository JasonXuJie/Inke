import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

///md5加密
String generateMd5(String data){
  final content = Utf8Encoder().convert(data);
  final digest = md5.convert(content);
  return hex.encode(digest.bytes);////这里其实就是 digest.toString()
}