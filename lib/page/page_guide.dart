import 'package:flutter/material.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/util/shared_util.dart';

class GuidePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GuidePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _renderViewPager() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Image.asset(
          AppImgPath.mainPath + 'img_guide_one.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          AppImgPath.mainPath + 'img_guide_two.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          AppImgPath.mainPath + 'img_guide_three.png',
          fit: BoxFit.fill,
        ),
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    AppImgPath.mainPath + 'img_guide_four.png',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: OutlineButton(
                    child: Text(
                      '立即体验',
                      style: const TextStyle(
                          color: Color(AppColors.colorPrimary), fontSize: 14.0),
                    ),
                    borderSide:
                    BorderSide(color: Color(AppColors.colorPrimary)),
                    onPressed: () {
                      SharedUtil.getInstance()
                          .put(SharedKey.isFirst, false);
                      RouteUtil.popAndPushByNamed(
                          context, RouteConfig.mainName);
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _renderSelector() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: TabPageSelector(
            color: Colors.white,
            selectedColor: Colors.blue,
            indicatorSize: 14.0,
            controller: _tabController,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _renderViewPager(),
          _renderSelector(),
        ],
      ),
    );
  }
}
