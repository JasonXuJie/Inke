import 'package:Inke/config/app_config.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/widgets/banner_view.dart';
import 'package:provider/provider.dart';
import 'package:Inke/widgets/dialog_loading.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/widget_refresh.dart';
import 'package:Inke/util/toast.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/widgets/dialog_feed_back.dart';

class MovieFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieFragment> with AutomaticKeepAliveClientMixin {
  var _cityName;
  List<MovieListEntity> dataList;

  @override
  bool get wantKeepAlive => true;

  Future<List<MovieListEntity>> _requestMovies(cityName) async {
    List<MovieListEntity> datas = [];
    var hotResponse = await HttpManager.getInstance().get(ApiService.getMovies,
        params: {'city': cityName, 'start': '0', 'count': '15'});
    var hotMovies = MovieListEntity.fromJson(hotResponse);
    datas.add(hotMovies);
    var moreResponse = await HttpManager.getInstance().get(ApiService.getMovies,
        params: {'city': cityName, 'start': '16', 'count': '25'});
    var moreMovies = MovieListEntity.fromJson(moreResponse);
    datas.add(moreMovies);
    return datas;
  }

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
          return FutureBuilder<List<MovieListEntity>>(
            future: _requestMovies(_cityName),
            builder: (BuildContext context,
                AsyncSnapshot<List<MovieListEntity>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return LoadingDialog(text: '加载中....');
                  break;
                default:
                  if (snapshot.hasError) {
                    return RefreshWidget(
                      callback: () {
                        setState(() {});
                      },
                    );
                  } else {
                    dataList = snapshot.data;
                    return _buildBody(
                        dataList[0].subjects, dataList[1].subjects);
                  }
              }
            },
          );
        }
      },
    );
  }

  _buildBody(
      List<MovieListSubject> hotMovies, List<MovieListSubject> moreMovies) {
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
              _buildButton(Alignment.topLeft, Consumer<CityProvider>(
                  builder: (context, CityProvider provider, _) {
                return Text(
                  provider.name,
                  style: TextStyles.whiteNormal14,
                );
              }), () {
                RouteUtil.pushByNamed(context, RouteConfig.cityName);
              }, l: 15.0, t: 50.0),
              _buildButton(
                  Alignment.topRight,
                  loadAssetImage('img_search', width: 25.0, height: 25.0),
                  () => RouteUtil.pushByNamed(context, RouteConfig.searchName),
                  t: 50.0,
                  r: 15.0),
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
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            sliver: FunView(),
          ),
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

///首页四个功能列表
class FunView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return _buildItem(index);
        }, childCount: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 2.0,
        ));
  }

  _buildItem(int index) {
    var title;
    var content;
    var color;
    switch (index) {
      case 0:
        title = '热门预告片';
        content = '精彩电影视频集锦';
        color = Colors.redAccent;
        break;
      case 1:
        title = '一日壹评';
        content = '每日推荐精彩影评论';
        color = Colors.greenAccent;
        break;
      case 2:
        title = '热议话题';
        content = '一起来讨论电影';
        color = Colors.blueAccent;
        break;
      case 3:
        title = '票票日签';
        content = '看经典电影台词';
        color = Colors.purpleAccent;
        break;
    }
    return GestureDetector(
        onTap: () => Toast.show('功能暂未开通'),
        child: Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 5.0,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyles.whiteW700_16,
                  ),
                  Text(content, style: TextStyles.whiteNormal12),
                ],
              ),
            )));
  }
}

class RedPacketBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      child: GestureDetector(
        onTap: () => Toast.show('活动已结束！明年再来吧～～～'),
        child: loadAssetImage('banner', format: 'jpeg', fit: BoxFit.cover),
      ),
    );
  }
}

///更多电影列表
class MoreMovieList extends StatelessWidget {
  final List movieList;

  MoreMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext ctx, int index) {
            return _buildItem(context, movieList[index], index);
          },
          childCount: movieList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0,
        ));
  }

  _buildItem(context, MovieListSubject subject, int index) {
    var isEven = index.isEven;
    var item = Column(
      children: <Widget>[
        Expanded(
            child: Stack(
          children: <Widget>[
            Hero(
              tag: 'photo${subject.id}',
              child: ClipRRect(
                child: loadNetworkImage(subject.images.medium,
                    width: MediaQuery.of(context).size.width),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0)),
              ),
              placeholderBuilder: (context, size, widget) {
                return Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.red,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '豆瓣评分:${subject.rating.average}',
                  style: const TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subject.title),
        ),
      ],
    );
    return Card(
      margin: EdgeInsets.only(
          left: isEven ? 10.0 : 0.0, right: isEven ? 0.0 : 10.0),
      elevation: 5.0,
      child: InkWell(
        child: item,
        onTap: () {
          RouteUtil.pushByWidget(
              context,
              MovieDetailsPage(
                data: subject,
              ));
        },
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FeedBackDialog(title: subject.title);
              });
        },
      ),
    );
  }
}

///热门电影列表
class HotMovieList extends StatelessWidget {
  final List<MovieListSubject> movieList;

  HotMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ...movieList.map((subject) {
            return _buildItem(context, subject);
          }).toList(),
          InkWell(
            onTap: () {
              RouteUtil.pushByNamed(context, RouteConfig.moreHotMoviesName);
            },
            child: Container(
              width: 130,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.color_f5,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: Text('查看全部', style: TextStyles.greyNormal15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, MovieListSubject subjects) {
    var _item = Container(
      width: 130.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: 'photo${subjects.id}',
                  child: ClipRRect(
                      child: loadNetworkImage(subjects.images.medium,
                          width: 130.0, height: 140.0, fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0))),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                        child: Text(
                          '豆瓣评分:${subjects.rating.average}',
                          style: TextStyles.orangeBold11,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              subjects.title,
              style: TextStyles.blackNormal14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: InkWell(
        child: _item,
        onTap: () {
          RouteUtil.pushByWidget(
              context,
              MovieDetailsPage(
                data: subjects,
              ));
        },
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FeedBackDialog(
                  title: subjects.title,
                );
              });
        },
      ),
    );
  }
}
