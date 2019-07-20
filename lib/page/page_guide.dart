import 'package:Inke/provider/first_provider.dart';
import 'package:flutter/material.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/config/route_config.dart';
import 'package:provider/provider.dart';
import 'package:Inke/util/image_util.dart';

import 'package:Inke/util/service_locator.dart';
import 'package:Inke/util/navigate_service.dart';

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
        loadAssetImage('img_guide_one',fit: BoxFit.fill),
        loadAssetImage('img_guide_two',fit: BoxFit.fill),
        loadAssetImage('img_guide_three',fit: BoxFit.fill),
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: loadAssetImage('img_guide_four',fit: BoxFit.fill),
                  ),
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
                          color: AppColors.colorPrimary, fontSize: 14.0),
                    ),
                    borderSide:
                    BorderSide(color: AppColors.colorPrimary),
                    onPressed: () {
                      Provider.of<FirstProvider>(context).setFirst(false);
                      RouteUtil.popAndPushByNamed(
                          context, RouteConfig.mainName);
                     //getIt<NavigateService>().pushNamed('/Main');

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
