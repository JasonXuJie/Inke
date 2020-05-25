import 'dart:math';

import 'package:Inke/config/shared_key.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:Inke/http/api.dart';
import 'package:Inke/modules/movie/view_banner.dart';
import 'package:provider/provider.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:Inke/widgets/refresh_helper.dart';
import 'package:Inke/modules/movie/view_classify.dart';
import 'package:Inke/modules/movie/view_function.dart';
import 'package:Inke/modules/movie/view_advertising.dart';
import 'package:Inke/modules/movie/list_hot_movie.dart';
import 'package:Inke/modules/movie/list_more_movie.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:Inke/widgets/loading.dart';

class MovieContainer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieContainer> with AutomaticKeepAliveClientMixin {

  var _cityName;
  List<MovieListSubject> dataList;

  RefreshController controller = RefreshController();

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    setState(() {
      _cityName = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _cityName =Provider.of<CityProvider>(context,listen: false).name;
    Api.getHomeData(_cityName, (data){
      if(mounted){
          setState(() {
            dataList = data.subjects;
          });
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build');
    final cityName = Provider.of<CityProvider>(context).name;
    if(_cityName != cityName){
        _cityName = cityName;
        setState(() {
          dataList = null;
        });
        Api.getHomeData(cityName, (data){
          if(mounted){
            setState(() {
              dataList = data.subjects;
            });
          }
        });
    }
     if(ObjectUtil.isEmptyList(dataList)){
       return LoadingDialog();
     }else{
       return _buildHome(dataList);
     }
  }

  Widget _buildHome(List<MovieListSubject> movies) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      enableScrollWhenTwoLevel: true,
      maxOverScrollExtent: 120,
      child: SmartRefresher(
        controller: controller,
        enableTwoLevel: true,
        enablePullDown: true,
        onRefresh: () async {
          _onRefresh();
          controller.refreshCompleted();
        },
        onTwoLevel: () {
          NavigatorUtil.push(context, Routes.twoFloor).whenComplete((){
            controller.twoLevelComplete();
          });
        },
        header: TwoFloorHeader(),
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: Stack(
                  children: <Widget>[
                    BannerView(
                      dataList: movies.take(4).toList(),
                    ),
                    _buildButton(Alignment.topLeft, Consumer<CityProvider>(
                        builder: (context, CityProvider provider, _) {
                      return Text(
                        provider.name,
                        style: TextStyles.whiteNormal14,
                      );
                    }), () {
                      NavigatorUtil.push(context, Routes.cityList);
                    }, l: 15.0, t: 50.0),
                    _buildButton(
                        Alignment.topRight,
                        loadAssetImage('img_search', width: 25.0, height: 25.0),
                        () =>
                            NavigatorUtil.push(context, Routes.search),

                        t: 50.0,
                        r: 15.0),
                  ],
                )),
                SliverToBoxAdapter(
                  child: AdvertView(),
                ),
                SliverToBoxAdapter(
                  child: _buildTitle('热门电影', () {
                  }),
                ),
                SliverToBoxAdapter(
                  child: HotMovieList(movieList: movies),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  sliver: FunctionView(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: _buildTitle('更多电影', () {

                    }),
                  ),
                ),
                MoreMovieList(
                  movieList: movies,
                ),
              ];
            },
            body: ClassifyView()),
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
