import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';

class TwoFloorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('欢迎来到二楼'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            //SmartRefresher.of(context).controller.twoLevelComplete();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          loadAssetImage('two_level_bg',
              format: 'jpeg',
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          Center(
            child: Text('灵魂就此安放与凤凰', style: TextStyles.whiteBold16),
          )
        ],
      ),
    );
  }
}
