import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class BaseWidget {

  ///骨架效果
  static Widget buildShimmer(context, {double width,double height}) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[100],
            highlightColor: Colors.white,
            child: Container(
              width: width ?? MediaQuery.of(context).size.width,
              color: Colors.white,
              height: height ?? 20.0,
            )));
  }
}
