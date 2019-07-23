import 'package:flutter/material.dart';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/bean/news_result_entity.dart';
import 'package:Inke/http/http_manager_jh.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/components/widget_refresh.dart';

class NewsList extends StatefulWidget {
  final String value;

  NewsList({Key key, @required this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NewsList> with AutomaticKeepAliveClientMixin{


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<NewsResultEntity>(
      future: _requestData(),
      builder: (BuildContext context, AsyncSnapshot<NewsResultEntity> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return LoadingView();
            break;
          default:
            if (snapshot.hasError) {
               return RefreshWidget(callback: (){
                 setState(() {

                 });
               },);
            } else {
              if (snapshot.data.result == null) {
                return Center(
                  child: Text('请求条数已使用完'),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: snapshot.data.result.data.length,
                      itemBuilder: (context, index) {
                        return _buildItem(
                            context, snapshot.data.result.data[index]);
                      }),
                );
              }
            }
        }
      },
    );
  }

  Future<NewsResultEntity> _requestData() async {
    var response = await HttpManager.getInstance()
        .get(ApiService.getNewsList, params: {'type': widget.value, 'key': ApiService.newsKey});
    return NewsResultEntity.fromJson(response);
  }

  Future<void> _onRefresh()async{
    setState(() {
    });
  }

  _buildItem(context, NewsResultResultData itemData) {
    return InkWell(
      onTap: () {
        RouteUtil.pushNamedByArgs(context, RouteConfig.webName, {'title':itemData.title,'url':itemData.url});
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                        child: Text(
                          itemData.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                              Text(
                                itemData.date,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
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
                    child: loadFadeInNetImage(itemData.thumbnailPicS,width: 80.0,height: 100.0),
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
