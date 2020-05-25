import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/app_bar.dart';
import 'package:Inke/widgets/text.dart';

class NotFoundPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.centerTitle('页面未找到'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loadAssetImage('img_loading_error', width: 80.0, height: 80.0),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '页面未找到',
                style: TextStyles.blackNormal12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
