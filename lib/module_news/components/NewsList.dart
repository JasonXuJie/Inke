import 'package:flutter/material.dart';
import '../../page/WebPage.dart';
import '../../bean/news_data.dart';
import '../../config/AppConfig.dart';
import '../../components/LoadingView.dart';
import '../../util/DioUtil.dart';
import '../../Api.dart';
import 'dart:async';

class NewsList extends StatelessWidget {

  String value;
  NewsList({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(value);
    return FutureBuilder<newsData>(
      future: _requestData(value),
      builder: (BuildContext context, AsyncSnapshot<newsData> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return LoadingView();
            break;
          default:
            if (snapshot.hasError) {
              return Text('错误:${snapshot.error.toString()}');
            } else {
              if (snapshot.data.result == null) {
                return Center(
                  child: Text('请求条数已使用完'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.result.data.length,
                    itemBuilder: (context, index) {
                      return _buildItem(context, snapshot.data.result.data[index]);
                    });
              }
            }
        }
      },
    );
  }

  Future<newsData> _requestData(String type) async {
    var response = await DioUtil.getJhInstance()
        .get(ApiService.NEWS, data: {'type': type, 'key': ApiService.NEWS_KEY});
    return newsData.fromJson(response);
  }

  _buildItem(context, Data itemData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebPage(url: itemData.url)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
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
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                              Text(
                                itemData.date,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
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
                    child: FadeInImage.assetNetwork(
                      placeholder: AppImgPath.mainPath + 'app_icon.png',
                      image: itemData.thumbnailPicS,
                      width: 80.0,
                      height: 100.0,
                      fit: BoxFit.fill,
                    ),
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
