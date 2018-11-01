import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../util/SharedUtil.dart';
import '../components/LoadingView.dart';
import '../bean/movie.dart';
import '../Api.dart';
import 'dart:async';
import 'commponents/CommingSoonList.dart';
import 'commponents/TopList.dart';
import '../config/AppConfig.dart';

class MoreMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoreMoviesState();
}

class _MoreMoviesState extends State<MoreMoviesPage> with SingleTickerProviderStateMixin{


  TabController _controller;

  Future<movie> _requestCommingSoon() async {
    var city = SharedUtil.getInstance().getCity()[SharedUtil.CITY_NAME];
    var response =
    await DioUtil.getInstance().get(ApiService.GET_COMMING_SOON, data: {
      'city': city,
      'start': '0',
      'count': '20',
    });
    return movie.fromJson(response);
  }

  Future<movie> _requestTop250() async {
    var response =
    await DioUtil.getInstance().get(ApiService.GET_TOP_250, data: {
      'start': '0',
      'count': '25',
    });
    return movie.fromJson(response);
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
      backgroundColor: Colors.black,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
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
            children: [
              _buildContainer(_requestCommingSoon(), flag: true),
              _buildContainer(_requestTop250(), flag: false)
            ],
          )
      )
    );
  }

  _buildContainer(requestData, {bool flag}) {
    return FutureBuilder<movie>(
      future: requestData,
      builder: (BuildContext context, AsyncSnapshot<movie> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return LoadingView();
            break;
          default:
            if (snapshot.hasError) {
              return Text('访问异常');
            } else {
              if (flag) {
                return CommingSoonList(
                  data: snapshot.data.subjects,
                );
              } else {
                return TopList(data: snapshot.data.subjects,);
              }
            }
        }
      },
    );
  }
}
