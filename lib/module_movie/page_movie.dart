import 'package:Inke/provider/city_provider.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:Inke/http/api.dart';
import 'package:Inke/module_movie/view_banner.dart';
import 'package:provider/provider.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:Inke/widgets/refresh_helper.dart';
import 'package:Inke/module_movie/view_classify.dart';
import 'package:Inke/module_movie/view_function.dart';
import 'package:Inke/module_movie/view_advertising.dart';
import 'package:Inke/module_movie/list_hot_movie.dart';
import 'package:Inke/module_movie/list_more_movie.dart';
import 'package:Inke/widgets/future_builder.dart';

class MovieFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieFragment> with AutomaticKeepAliveClientMixin {
  var _cityName;
  List<MovieListEntity> dataList;

  RefreshController controller = RefreshController();

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    setState(() {
      _cityName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CityProvider>(
      builder: (context, CityProvider provider, _) {
        if (_cityName == provider.name && dataList != null) {
          return _buildBody(dataList[0].subjects, dataList[1].subjects);
        } else {
          _cityName = provider.name;
          return FutureContainer<List<MovieListEntity>>(
            future: Api.getHomeList(_cityName),
            dataWidget: (List<MovieListEntity> data) {
              dataList = data;
              return _buildBody(dataList[0].subjects, dataList[1].subjects);
            },
          );
        }
      },
    );
  }

  _buildBody(
      List<MovieListSubject> hotMovies, List<MovieListSubject> moreMovies) {
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
          RouteUtil.pushNamed(context, RouteName.twoFloorName).whenComplete(() {
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
                      dataList: hotMovies.take(4).toList(),
                    ),
                    _buildButton(Alignment.topLeft, Consumer<CityProvider>(
                        builder: (context, CityProvider provider, _) {
                      return Text(
                        provider.name,
                        style: TextStyles.whiteNormal14,
                      );
                    }), () {
                      RouteUtil.pushNamed(context, RouteName.cityName);
                    }, l: 15.0, t: 50.0),
                    _buildButton(
                        Alignment.topRight,
                        loadAssetImage('img_search', width: 25.0, height: 25.0),
                        () =>
                            RouteUtil.pushNamed(context, RouteName.searchName),
                        t: 50.0,
                        r: 15.0),
                  ],
                )),
                SliverToBoxAdapter(
                  child: AdvertView(),
                ),
                SliverToBoxAdapter(
                  child: _buildTitle('热门电影', () {
                    RouteUtil.pushNamed(context, RouteName.moreHotMoviesName);
                  }),
                ),
                SliverToBoxAdapter(
                  child: HotMovieList(movieList: hotMovies),
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
                  movieList: moreMovies,
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
