import 'package:Inke/config/shared_key.dart';
import 'package:flutter/material.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:flustars/flustars.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildViewPager(),
          _buildSelector(),
        ],
      ),
    );
  }

  Widget _buildViewPager() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        loadAssetImage('img_guide_one', fit: BoxFit.fill),
        loadAssetImage('img_guide_two', fit: BoxFit.fill),
        loadAssetImage('img_guide_three', fit: BoxFit.fill),
        Stack(
          fit: StackFit.expand,
          children: <Widget>[
            loadAssetImage('img_guide_four', fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.only(bottom:100.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: OutlineButton(
                    child: Text(
                      '立即体验',
                      style: TextStyles.mainNormal14,
                    ),
                    borderSide: BorderSide(color: AppColors.colorPrimary),
                    onPressed: () {
                      SpUtil.putBool(SharedKey.isFirst, false);
                      NavigatorUtil.pushAndReplace(context, Routes.main);
                      //getIt<NavigateService>().pushNamed('/Main');
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelector() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: TabPageSelector(
            color: Colors.white,
            selectedColor: Colors.blue,
            indicatorSize: 14.0,
            controller: _tabController,
          ),
        ));
  }
}
