import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerView extends StatelessWidget {
  final _shimmerHeight = 50;

  @override
  Widget build(BuildContext context) {
    var count = MediaQuery.of(context).size.height / _shimmerHeight;
    print('个数:$count');
    return SafeArea(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            child: Column(
              children:
                  List.generate(count.toInt(), (index) => _buildItemSkeleton()),
            ),
          )),
    );
  }

  _buildItemSkeleton() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      height: 40,
      color: Colors.grey[300],
    );
  }
}


