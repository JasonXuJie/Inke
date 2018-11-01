import 'package:flutter/material.dart';
import '../../config/AppConfig.dart';
import '../../util/ToastUtil.dart';

class RedPacketBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      child: GestureDetector(
        onTap: () => ToastUtil.showShortToast('活动已结束！明年再来吧～～～'),
        child: Image.asset(AppImgPath.mainPath + 'banner.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}