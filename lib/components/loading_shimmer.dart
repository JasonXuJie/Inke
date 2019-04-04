import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildImgPlaceHolder(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildPlaceHolder(context, width: 200.0),
                    _buildPlaceHolder(context, width: 100.0),
                    _buildPlaceHolder(context, width: 50.0),
                  ],
                )
              ],
            ),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context),
            _buildPlaceHolder(context, width: 300.0),
            _buildPlaceHolder(context, width: 200.0),
            _buildPlaceHolder(context, width: 100.0),
            _buildPlaceHolder(context, width: 50.0),
          ],
        ),
      ),
    );
  }

  _buildImgPlaceHolder() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100],
        highlightColor: Colors.white,
        child: Container(
          color: Colors.white,
          width: 120.0,
          height: 120.0,
        ),
      ),
    );
  }

  _buildPlaceHolder(context, {double width}) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[100],
            highlightColor: Colors.white,
            child: Container(
              width: width ?? MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 20.0,
            )));
  }
}
