import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:Inke/util/image_util.dart';

class TwoLevelExample extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TwoLevelExample> {
  RefreshController _refreshController1 = RefreshController();
  RefreshController _refreshController2 = RefreshController();
  int _tabIndex = 0;

  @override
  void initState() {
    _refreshController1.headerMode.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshController1.position.jumpTo(0);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      enableScrollWhenTwoLevel: true,
      maxOverScrollExtent: 120,
      child: Scaffold(
        bottomNavigationBar: !_refreshController1.isTwoLevel
            ? BottomNavigationBar(
                currentIndex: _tabIndex,
                onTap: (index) {
                  _tabIndex = index;
                  if (mounted) setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), title: Text("二级刷新例子1")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.border_clear), title: Text("二级刷新例子2"))
                ],
              )
            : null,
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: _tabIndex != 0,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints cons) {
                  return SmartRefresher(
                    controller: _refreshController1,
                    enableTwoLevel: true,
                    enablePullUp: true,
                    enablePullDown: true,
                    onLoading: () async {
                      await Future.delayed(Duration(milliseconds: 2000));
                      _refreshController1.loadComplete();
                    },
                    onRefresh: () async {
                      await Future.delayed(Duration(milliseconds: 2000));
                      _refreshController1.refreshCompleted();
                    },
                    onTwoLevel: () {},
                    header: TwoLevelHeader(
                      textStyle: TextStyle(color: Colors.white),
                      displayAlignment: TwoLevelDisplayAlignment.fromTop,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  getImgPath('history_bg', format: 'jpeg')),
                              fit: BoxFit.cover,
                              // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
                              alignment: Alignment.topCenter)),
                      twoLevelWidget: TwoLevelWidget(),
                    ),
                    child: CustomScrollView(
                      physics: ClampingScrollPhysics(),
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(
                            height: 500,
                            child: Scaffold(
                              appBar: AppBar(),
                              body: Column(
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("点击这里返回上一页!"),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      _refreshController1.requestTwoLevel();
                                    },
                                    child: Text("点击这里打开二楼!"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Offstage(
              offstage: _tabIndex != 1,
              child: SmartRefresher(
                header: ClassicHeader(),
                child: CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.red,
                        height: 680,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("点击这里返回上一页!"),
                        ),
                      ),
                    )
                  ],
                ),
                controller: _refreshController2,
                enableTwoLevel: true,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 2000));
                  _refreshController2.refreshCompleted();
                },
                onTwoLevel: () {
                  print("Asd");
                  _refreshController2.position.hold(() {});
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (c) => Scaffold(
                                appBar: AppBar(),
                                body: Text("二楼刷新"),
                              )))
                      .whenComplete(() {
                    _refreshController2.twoLevelComplete(
                        duration: Duration(microseconds: 1));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TwoLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(getImgPath('history_bg', format: 'jpeg')),
            fit: BoxFit.cover,
            // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果,关联到TwoLevelHeader,如果背景一致的情况,请设置相同
            alignment: Alignment.topCenter),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Wrap(
              children: <Widget>[
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {},
                  child: Text('登陆'),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            height: 60,
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                SmartRefresher.of(context).controller.twoLevelComplete();
              },
            ),
          )
        ],
      ),
    );
  }
}
