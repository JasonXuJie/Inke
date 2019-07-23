import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/components/text.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面未找到'),
        centerTitle: true,

      ),
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
