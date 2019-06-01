import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/components/banner_view.dart';
import 'commponents/hot_movies_list_view.dart';
import 'package:Inke/components/dialog_loading.dart';
import 'commponents/more_movies_list_view.dart';
import 'commponents/red_packet_banner_view.dart';
import 'commponents/func_view.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/qr_scan_util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/redux/global_state.dart';
import 'package:Inke/bean/city.dart';
import 'package:async/async.dart';
import 'package:redux/redux.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';

import 'package:Inke/http/http_manager.dart';
import 'package:Inke/util/toast_util.dart';

class MovieFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieFragment> with AutomaticKeepAliveClientMixin{

  AsyncMemoizer<List<MovieListEntity>> _memoizer = AsyncMemoizer();
  var _cityName;
  int firstTime = 0;

  @override
  void initState(){
    super.initState();
    print('Movie State');
  }

  @override
  bool get wantKeepAlive => true;



  Store<GlobalState> _getStore() {
    if (context == null) {
      return null;
    }
    return StoreProvider.of<GlobalState>(context);
  }

  _request(cityName) {
    if (_cityName == cityName) {
      return _memoizer.runOnce(() async {
        return _requestMovies(cityName);
      });
    } else {
      _cityName = cityName;
      return _requestMovies(cityName);
    }
  }

  Future<List<MovieListEntity>> _requestMovies(cityName) async {
    List<MovieListEntity> datas = [];
    var hotResponse = await HttpManager.getInstance().get(ApiService.getMovies,
        params: {'city': cityName, 'start': '0', 'count': '15'});
    var hotMovies = MovieListEntity.fromJson(hotResponse);
    datas.add(hotMovies);
    var moreResponse = await HttpManager.getInstance().get(
        ApiService.getMovies,
        params: {'city': cityName, 'start': '16', 'count': '25'});
    var moreMovies = MovieListEntity.fromJson(moreResponse);
    datas.add(moreMovies);
    return datas;
  }

  Future<void> _onRefresh() async {
    setState(() {
      _memoizer = AsyncMemoizer();
      _cityName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Movie build');
    return WillPopScope(
        child: Scaffold(
          body: StoreConnector<GlobalState, City>(
            converter: (store) => store.state.city,
            builder: (context, city) {
              return FutureBuilder<List<MovieListEntity>>(
                future: _request(city.name),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieListEntity>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return LoadingView(
                        text: '加载中...',
                      );
                      break;
                    default:
                      if (snapshot.hasError) {
                        return Text('访问异常');
                      } else {
                        return _buildBody(
                            snapshot.data[0].subjects, snapshot.data[1].subjects);
                      }
                  }
                },
              );
            },
          ),
        ),
        onWillPop: (){
          ///双击退出
          int secondTime = DateTime.now().millisecondsSinceEpoch;
          if(secondTime - firstTime >2000){
            ToastUtil.showShortToast('再按一次退出程序');
            firstTime = secondTime;
            return Future.value(false);
          }else {
            return Future.value(true);
          }
        }
    );
  }

  _buildBody(List<MovieListSubject> hotMovies, List<MovieListSubject> moreMovies) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Stack(
            children: <Widget>[
              BannerView(
                dataList: hotMovies.take(4).toList(),
              ),
              _buildButton(
                  Alignment.topLeft,
                  StoreConnector<GlobalState, City>(
                      converter: (store) => store.state.city,
                      builder: (context, city) {
                        return Text(
                          city.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        );
                      }), () {
                RouteUtil.pushByNamed(context, RouteConfig.cityName);
              }, l: 15.0, t: 50.0),
              _buildButton(
                  Alignment.topRight,
                  Image.asset(
                    AppImgPath.mainPath + 'img_search.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  () => RouteUtil.pushByNamed(context, RouteConfig.searchName),
                  t: 50.0,
                  r: 15.0),
              _buildButton(
                  Alignment.topRight,
                  Image.asset(
                    AppImgPath.mainPath + 'img_scan.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  () => QrScanUtil.scan(),
                  t: 50.0,
                  r: 50.0),
            ],
          )),
          SliverToBoxAdapter(
            child: RedPacketBanner(),
          ),
          SliverToBoxAdapter(
            child: _buildTitle('热门电影', () {
              RouteUtil.pushByNamed(context, RouteConfig.moreHotMoviesName);
            }),
          ),
          SliverToBoxAdapter(
            child: HotMovieList(movieList: hotMovies),
          ),
          FunView(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10.0),
            sliver: SliverToBoxAdapter(
              child: _buildTitle('更多电影', () {
                RouteUtil.pushByNamed(context, RouteConfig.moreMoviesName);
              }),
            ),
          ),
          MoreMovieList(
            movieList: moreMovies,
          ),
        ],
      ),
    );
  }

  _buildTitle(String label, VoidCallback callBack) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                color: Colors.orange[800],
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            child: Row(
              children: <Widget>[
                Text(
                  '更多',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0),
                ),
                Icon(Icons.arrow_right)
              ],
            ),
            onTap: callBack,
          )
        ],
      ),
    );
  }

  _buildButton(Alignment alignment, Widget widget, VoidCallback callBack,
      {double l, double t, double r, double b}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.fromLTRB(l ?? 0, t ?? 0, r ?? 0, b ?? 0),
        child: GestureDetector(
          onTap: callBack,
          child: widget,
        ),
      ),
    );
  }




}
