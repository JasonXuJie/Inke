import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/util/toast.dart';
class RedPacketBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      child: GestureDetector(
        onTap: () => Toast.show('活动已结束！明年再来吧～～～'),
        child: Image.asset( getImgPath('banner',format: 'jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}