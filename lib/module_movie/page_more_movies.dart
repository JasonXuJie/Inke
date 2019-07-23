import 'package:flutter/material.dart';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'commponents/comming_soon_list_view.dart';
import 'commponents/top_list_view.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/components/widget_refresh.dart';

class MoreMoviesPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MoreMoviesPage> with SingleTickerProviderStateMixin {

  TabController _controller;
  MovieListEntity data;


  Future<MovieListEntity> _requestCommingSoon(cityName) async {
    var response =
        await HttpManager.getInstance().get(ApiService.getCommingSoonMovie, params: {
      'city': cityName,
      'start': '0',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }


  Future<void> _onRefresh() async {
    setState(() {

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
      builder: (context,CityProvider provider,_){
        if(data == null){
          return FutureBuilder<MovieListEntity>(
            future: _requestCommingSoon(provider.name),
            builder: (BuildContext context, AsyncSnapshot<MovieListEntity> snapshot) {
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
        }else{

        }

      },
    );
  }

  _buildTopContainer() {
    return TopList();
  }
}
