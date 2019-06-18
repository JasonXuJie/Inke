import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/components/loading_view.dart';
import 'commponents/more_hot_movie_list.dart';
import 'package:Inke/bean/city.dart';
import 'package:async/async.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';

class MoreHotMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MoreHotMoviesPage> {
  AsyncMemoizer<MovieListEntity> _memoizer = AsyncMemoizer();

  Future<MovieListEntity> _requestMoreHotMovies(cityName) async {
    var response =
        await HttpManager.getInstance().get(ApiService.getMovies, params: {
      'city': cityName,
      'start': '16',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  Future<MovieListEntity> _requestOnce(cityName) async {
    return _memoizer.runOnce(() async {
      return _requestMoreHotMovies(cityName);
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _memoizer = AsyncMemoizer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更多热门电影'),
        centerTitle: true,
      ),
      body:
          Consumer<CityProvider>(builder: (context, CityProvider provider, _) {
        return FutureBuilder<MovieListEntity>(
            future: _requestOnce(provider.name),
            builder: (BuildContext context,
                AsyncSnapshot<MovieListEntity> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return LoadingView();
                  break;
                default:
                  if (snapshot.hasError) {
                    return Text('出现异常');
                  } else {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: MoreHotMoviesList(data: snapshot.data.subjects),
                    );
                  }
              }
            });
      }),
    );
  }
}
