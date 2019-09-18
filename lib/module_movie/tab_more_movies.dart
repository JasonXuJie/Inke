import 'package:flutter/material.dart';
import 'package:Inke/widgets//loading_view.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/widgets/widget_refresh.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/config/route_config.dart';

class TabMore extends StatelessWidget {
  final tabs = [Tab(text: '即将上映'), Tab(text: 'Top250榜单'), Tab(text: '其它')];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16.0,
                ),
                labelStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                tabs: tabs),
                Expanded(
                  child:  CommingSoonList(),
                )
            // Expanded(
            //   child: TabBarView(
            //     children: <Widget>[
            //       //CommingSoonList(),
            //        OtherWidget(),
            //       Container(
            //         height: 150,
            //         child: Center(
            //           child: Text('222222'),
            //         ),
            //       ),
            //       OtherWidget(),
            //     ],
            //   ),
            // ),
          ],
        ))
    );
  }
}

///即将上映列表
class CommingSoonList extends StatelessWidget {
  Future<MovieListEntity> _requestCommingSoon(cityName) async {
    var response = await HttpManager.getInstance()
        .get(Api.getCommingSoonMovie, params: {
      'city': cityName,
      'start': '0',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(
      builder: (context, CityProvider provider, _) {
        return FutureBuilder<MovieListEntity>(
          future: _requestCommingSoon(provider.name),
          builder:
              (BuildContext context, AsyncSnapshot<MovieListEntity> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return LoadingView();
                break;
              default:
                if (snapshot.hasError) {
                  return RefreshWidget(
                    callback: () {},
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.subjects.length,
                    itemBuilder: (BuildContext context, int pos) {
                      return _buildItem(context, snapshot.data.subjects[pos]);
                    },
                  );
                }
            }
          },
        );
      },
    );
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + '  ';
    });
    // var casts = List.generate(itemData.casts.length, (index) {
    //   return itemData.casts[index].avatars ?? Padding(
    //     padding: const EdgeInsets.only(left: 5.0),
    //     child: loadFadeInNetImage(itemData.casts[index].avatars.medium,
    //         width: 50.0, height: 50.0, placeholder: 'app_icon'),
    //   );
    // });
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: InkWell(
        onTap: () {
          RouteUtil.pushWidget(
              context,
              MovieDetailsPage(
                data: itemData,
              ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
              child: loadFadeInNetImage(itemData.images.medium,
                  width: 100.0, height: 150.0, placeholder: 'app_icon'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(itemData.title, style: TextStyles.blackBold18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('类型:$genres', style: TextStyles.blackNormal14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('上映时间:${itemData.year}',
                        style: TextStyles.blackNormal14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '主演:',
                          style: TextStyles.blackNormal14,
                        ),
                        // Wrap(
                        //   children: casts,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

///Top榜单

///其它功能
class OtherWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('功能暂未开放'),
    );
  }
}

