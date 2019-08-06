import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Inke/config/app_config.dart';

///加载本地资源图片
Widget loadAssetImage(String name,{double width,double height,String format,BoxFit fit}){
  return Image.asset(
    getImgPath(name,format: format),
    height: height,
    width: width,
    fit: fit,
  );
}

Widget loadNetImage(String url,{double width,double height,BoxFit fit:BoxFit.cover}){
  return Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
  );
}

///加载网络图片
///@placeholder 默认加载的图片为none
Widget loadNetworkImage(String url,{String placeholder:"none",double width,double height,BoxFit fit:BoxFit.cover}){
  return CachedNetworkImage(
      imageUrl: url == null?"":url,
      placeholder: (context,url)=>loadAssetImage(placeholder,height: height,width: width,fit: fit),
      errorWidget: (context,url,error)=>loadAssetImage(placeholder,height: height,width: width,fit: fit),
      width: width,
      height: height,
      fit: fit,
  );
}

///加载网络图片(带淡入淡出效果)
Widget loadFadeInNetImage(String url,{String placeholder:"none",double width,double height,BoxFit fit:BoxFit.fill,int fadeIn:700,int fadeOut:300}){
  return FadeInImage.assetNetwork(
    placeholder: getImgPath(placeholder),
    image: url == null ? "" : url,
    width: width,
    height: height,
    fit: fit,
    fadeInDuration: Duration(milliseconds: fadeIn),
    fadeOutDuration: Duration(milliseconds: fadeOut),
  );
}


String getImgPath(String name,{String format = 'png'}){
    return AppImgPath.mainPath+'$name.${format ?? 'png'}';
}





