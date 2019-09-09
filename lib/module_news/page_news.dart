import 'package:flutter/material.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/news_result_entity.dart';
import 'package:Inke/http/http_manager_jh.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/widget_my_future.dart';

class NewsPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<NewsPage> with AutomaticKeepAliveClientMixin {
  final Map<String, String> tabs = {'头条': 'top', '国内': 'guonei', '国际': 'guoji'};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabs.keys.length,
      child: Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () =>
                  RouteUtil.pushByNamed(context, RouteConfig.searchName),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text('请输入要搜索的内容',
                              style: TextStyles.greyNormal13)),
                    )
                  ],
                ),
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14.0,
                ),
                labelStyle: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                tabs: List.generate(
                    tabs.keys.length,
                    (index) => Tab(
                          text: tabs.keys.elementAt(index),
                        ))),
          ),
          body: TabBarView(
              children: List.generate(tabs.values.length,
                  (index) => NewsList(value: tabs.values.elementAt(index))))),
    );
  }
}

class NewsList extends StatefulWidget {
  final String value;

  NewsList({Key key, @required this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewState();
}

class _ViewState extends State<NewsList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilderWidget<NewsResultEntity>(
      loadFuture: _requestData(),
      loadingWidget: LoadingView(),
      buildDataWidget: _DataWidget(
        onRefresh: _onRefresh,
      ),
      defaultErrorCallback: () {
        setState(() {});
      },
    );
  }

  Future<NewsResultEntity> _requestData() async {
    var response = await HttpManager.getInstance().get(ApiService.getNewsList,
        params: {'type': widget.value, 'key': ApiService.newsKey});
    return NewsResultEntity.fromJson(response);
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }
}

class _DataWidget extends DataWidget<NewsResultEntity> {
  final Function onRefresh;
  _DataWidget({@required this.onRefresh});

  @override
  Widget buildContainer(NewsResultEntity data) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
          itemCount: data.result.data.length,
          itemBuilder: (context, index) {
            return _buildItem(context, data.result.data[index]);
          }),
    );
  }

  _buildItem(context, NewsResultResultData itemData) {
    return InkWell(
      onTap: () {
        RouteUtil.pushNamedByArgs(context, RouteConfig.webName,
            {'title': itemData.title, 'url': itemData.url});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 250.0,
                        child: Text(itemData.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.blackBold17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: SizedBox(
                          width: 250.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '来源:${itemData.authorName}',
                                style: TextStyles.greyNormal12,
                              ),
                              Text(
                                itemData.date,
                                style: TextStyles.greyNormal10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20.0),
                    child: loadFadeInNetImage(itemData.thumbnailPicS,
                        width: 80.0, height: 100.0),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
