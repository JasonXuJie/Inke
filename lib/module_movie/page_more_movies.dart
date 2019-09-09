import 'package:flutter/material.dart';
import 'package:Inke/widgets//loading_view.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/widgets/widget_refresh.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/util/route_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class MoreMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MoreMoviesPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  MovieListEntity data;

  Future<MovieListEntity> _requestCommingSoon(cityName) async {
    var response = await HttpManager.getInstance()
        .get(ApiService.getCommingSoonMovie, params: {
      'city': cityName,
      'start': '0',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text('更多电影'),
                  centerTitle: true,
                  bottom: TabBar(
                      controller: _controller,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.white54,
                      labelColor: Colors.white,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(
                          text: '即将上映',
                        ),
                        Tab(
                          text: 'Top250榜单',
                        )
                      ]),
                )
              ];
            },
            body: TabBarView(
              controller: _controller,
              children: [_buildCommingSoonContainer(), _buildTopContainer()],
            )));
  }

  _buildCommingSoonContainer() {
    return Consumer<CityProvider>(
      builder: (context, CityProvider provider, _) {
        if (data == null) {
          return FutureBuilder<MovieListEntity>(
            future: _requestCommingSoon(provider.name),
            builder: (BuildContext context,
                AsyncSnapshot<MovieListEntity> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return LoadingView();
                  break;
                default:
                  if (snapshot.hasError) {
                    return RefreshWidget(
                      callback: () {
                        setState(() {});
                      },
                    );
                  } else {
                    data = snapshot.data;
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: CommingSoonList(
                        data: data.subjects,
                      ),
                    );
                  }
              }
            },
          );
        } else {}
      },
    );
  }

  _buildTopContainer() {
    return TopList();
  }
}

class TopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopState();
}

class _TopState extends State<TopList> {
  var _refreshController = RefreshController();
  List<MovieListSubject> data = [];
  var start = 0;
  @override
  void initState() {
    super.initState();
    _requestTop250(start).then((movie) {
      setState(() {
        data = movie.subjects;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return LoadingView();
    } else {
      return SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: MaterialClassicHeader(),
        footer: _buildFooter(),
        controller: _refreshController,
        child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return _buildItem(context, data[index]);
            }),
      );
    }
  }

  _buildHeader(context, mode) {
    // return new ClassicIndicator(
    //   mode: mode,
    //   height: 40.0,
    //   releaseText: '松开手刷新',
    //   refreshingText: '刷新中',
    //   completeText: '刷新完成',
    //   failedText: '刷新失败',
    //   idleText: '下拉刷新',
    // );
  }

  _buildFooter() {
    return ClassicFooter(
      failedText: '加载失败',
      idleText: '无加载',
      loadingText: '加载中...',
      noDataText: '再无更多数据...',
    );
  }

  ///下拉刷新
  _onRefresh() {
    start = 0;
    _requestTop250(start).then((movie) {
      setState(() {
        data = movie.subjects;
      });
      _refreshController.refreshCompleted();
      //_refreshController.sendBack(up, RefreshStatus.completed);
      //_refreshController.sendBack(false, RefreshStatus.canRefresh);
    });
  }

  //上拉加载
  _onLoading() {
    start += 20;
    _requestTop250(start).then((movie) {
      if (movie.subjects.length == 0) {
        _refreshController.loadNoData();
        //_refreshController.sendBack(up, RefreshStatus.noMore);
      } else {
        setState(() {
          data.addAll(movie.subjects);
        });
        _refreshController.loadComplete();
        //_refreshController.sendBack(up, RefreshStatus.canRefresh);
      }
    });
  }

  Future<MovieListEntity> _requestTop250(int start) async {
    var response =
        await HttpManager.getInstance().get(ApiService.getTop250, params: {
      'start': '$start',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + ' ';
    });
    return InkWell(
      onTap: () {
        RouteUtil.pushByWidget(
            context,
            MovieDetailsPage(
              data: itemData,
            ));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 0.0),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: loadFadeInNetImage(itemData.images.medium,
                  width: 120.0, height: 80.0, placeholder: 'app_icon'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(itemData.title, style: TextStyles.blackBold16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text('类型:' + genres, style: TextStyles.blackNormal14),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '上映时间:${itemData.year}',
                style: TextStyles.blackNormal14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text('评分:${itemData.rating.average}',
                  style: TextStyles.blackNormal14),
            ),
          ],
        ),
      ),
    );
  }
}

class CommingSoonList extends StatelessWidget {
  final List<MovieListSubject> data;

  CommingSoonList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(context, data[index]);
        });
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + '  ';
    });
    var casts = List.generate(itemData.casts.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: loadFadeInNetImage(itemData.casts[index].avatars.medium,
            width: 50.0, height: 50.0, placeholder: 'app_icon'),
      );
    });
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: InkWell(
        onTap: () {
          RouteUtil.pushByWidget(
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
                        Wrap(
                          children: casts,
                        ),
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
