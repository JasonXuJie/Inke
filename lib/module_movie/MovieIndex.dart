import 'package:flutter/material.dart';
import '../Api.dart';
import '../components/BannerView.dart';
import '../util/SharedUtil.dart';
import '../util/DioUtil.dart';
import '../bean/movie.dart';
import 'commponents/HotMovieList.dart';
import 'dart:async';
import '../components/LoadingView.dart';
import 'commponents/MoreMovieList.dart';
import 'commponents/RedPacketBanner.dart';
import 'commponents/FunView.dart';
import '../config/AppConfig.dart';
import '../util/RouteUtil.dart';
import '../config/RouteConfig.dart';
import '../config/SharedKey.dart';
import '../util/QrScanUtil.dart';

class MovieFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieFragment> {
  List<Subjects> _hotMovies = [];
  List<Subjects> _moreMovies = [];
  var cityName = '';

  @override
  void initState() {
    super.initState();
    cityName = SharedUtil.getInstance().get(SharedKey.CITY_NAME, '上海');
    _requestHotMovies();
    _requestMoreMovies();
  }

  _requestHotMovies({String cityName = '上海'}) async {
    var response = await DioUtil.getInstance().get(ApiService.GET_MOVIES,
        data: {'city': cityName, 'start': '0', 'count': '15'});
    var json = movie.fromJson(response);
    setState(() {
      _hotMovies = json.subjects;
    });
  }

  _requestMoreMovies({String cityName = '上海'}) async {
    var response = await DioUtil.getInstance().get(ApiService.GET_MOVIES,
        data: {'city': cityName, 'start': '16', 'count': '25'});
    var json = movie.fromJson(response);
    setState(() {
      _moreMovies = json.subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (_hotMovies.length != 0) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Stack(
            children: <Widget>[
              BannerView(
                dataList: _hotMovies,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                  child: GestureDetector(
                    onTap: (){
                      RouteUtil.pushByNamed(context, RouteConfig.CITY_PATH)
                      .then((result){
                        if(result!=null){
                          setState(() {
                            cityName = result;
                            _requestHotMovies(cityName: cityName);
                            _requestMoreMovies(cityName: cityName);
                          });
                        }
                      });
                    },
                    child: Text(
                      cityName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 15.0, 0.0),
                    child: GestureDetector(
                      onTap: ()=>RouteUtil.pushByNamed(context, RouteConfig.SEARCH_PATH),
                      child: Image.asset(
                        AppImgPath.mainPath + 'img_search.png',
                        width: 25.0,
                        height: 25.0,
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 50.0, 0.0),
                  child: GestureDetector(
                    onTap: ()=>QrScanUtil.scan(),
                    child: Image.asset(
                      AppImgPath.mainPath + 'img_scan.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                  ),
                ),
              )
            ],
          )),
          SliverToBoxAdapter(
            child: RedPacketBanner(),
          ),
          SliverToBoxAdapter(
            child: _buildTitle('热门电影'),
          ),
          SliverToBoxAdapter(
            child: HotMovieList(movieList: _hotMovies),
          ),
          FunView(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10.0),
            sliver: SliverToBoxAdapter(
              child: _buildTitle('更多电影'),
            ),
          ),
          MoreMovieList(
            movieList: _moreMovies,
          ),
        ],
      );
    } else {
      return LoadingView();
    }
  }

  _buildTitle(String label) {
    return Padding(
      padding: EdgeInsets.all(10.0),
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
            onTap: () {
              switch (label) {
                case '热门电影':
                  Navigator.pushNamed(context, '/MoreHotMovies');
                  break;
                case '更多电影':
                  Navigator.pushNamed(context, '/MoreMovies');
                  break;
              }
            },
          )
        ],
      ),
    );
  }

}
