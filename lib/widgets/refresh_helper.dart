import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/modules/movie/page_two_floor.dart';

///全局配置刷新控件
class RefreshConfig extends StatelessWidget {
  final Widget child;

  RefreshConfig({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerTriggerDistance: 100, // 头部触发刷新的越界距离
      footerTriggerDistance: 20,
      maxOverScrollExtent: 140, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 0, //底部最大可以拖动的范围
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => RefreshFooter(),
      autoLoad: true,
      child: child,
      enableBallisticLoad: true, //可以通过惯性滑动触发加载更多
      hideFooterWhenNotFull: true, //Viewport不满一屏时,禁用上拉加载更多功能
      enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
    );
  }
}

///二楼头部
class TwoFloorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwoLevelHeader(
      idleText: '下拉可刷新',
      releaseText: '释放可刷新',
      refreshingText: '刷新中....',
      completeText: '刷新完成',
      canTwoLevelText: '欢迎来到二楼',
      textStyle: TextStyles.whiteNormal14,
      displayAlignment: TwoLevelDisplayAlignment.fromTop,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(getImgPath('two_floor_bg')),
        fit: BoxFit.cover,

        ///很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
        alignment: Alignment.topCenter,
      )),
      twoLevelWidget: Container(),
      ///如果这里设置了第二楼控件，会出现底部的bottomNavigation还是存在的情况，只能在onTwoLevel监听中进行页面跳转才不会出现这种情况
      //twoLevelWidget: TwoFloorPage(),
    );
  }
}

///通用Header
class RefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

///通用Footer
class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: '加载失败',
      idleText: '无加载',
      loadingText: '加载中...',
      noDataText: '再无更多数据...',
    );
  }
}
