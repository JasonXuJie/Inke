import 'package:flutter/material.dart';
import 'package:Inke/http/dio_util.dart';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'commponents/comming_soon_list_view.dart';
import 'commponents/top_list_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/redux/global_state.dart';
import 'package:Inke/bean/city.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';

class MoreMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MoreMoviesPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  var isRefresh = false;

  Future<MovieListEntity> _requestCommingSoon(cityName) async {
    var response =
        await DioUtil.getInstance().get(ApiService.GET_COMMING_SOON, data: {
      'city': cityName,
      'start': '0',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }


  Future<void> _onRefresh() async {
    setState(() {
      isRefresh = true;
    });
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
    print('更多电影');
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
    return StoreConnector<GlobalState, City>(
      converter: (store) => store.state.city,
      builder: (context, city) {
        return FutureBuilder<MovieListEntity>(
          future: _requestCommingSoon(city.name),
          builder: (BuildContext context, AsyncSnapshot<MovieListEntity> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return LoadingView();
                break;
              default:
                if (snapshot.hasError) {
                  return Text('${snapshot.error.toString()}');
                } else {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: CommingSoonList(
                      data: snapshot.data.subjects,
                    ),
                  );
                }
            }
          },
        );
      },
    );
  }

  _buildTopContainer() {
    return TopList();
  }
}
