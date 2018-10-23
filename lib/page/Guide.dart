import 'package:flutter/material.dart';
import '../config/AppConfig.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuideState();
}

class _GuideState extends State<GuidePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  _GuideState() {
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  @override
  void initState() {
    super.initState();
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 60.0),
                child: OutlineButton(
                    child: Text('立即登陆',
                      style: TextStyle(color: Color(AppColors.colorPrimary)),),
                    borderSide: BorderSide(
                        color: Color(AppColors.colorPrimary)),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route)=>route==null);
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
    return Container(
      child: Stack(
        children: <Widget>[
          _renderViewPager(),
          _renderSelector(),
        ],
      ),
    );
  }
}
