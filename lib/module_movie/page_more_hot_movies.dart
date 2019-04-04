import 'package:flutter/material.dart';
import 'package:Inke/http/dio_util.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/components/loading_view.dart';
import 'commponents/more_hot_movie_list.dart';
import 'package:Inke/redux/global_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/bean/city.dart';
import 'package:async/async.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';

class MoreHotMoviesPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MoreHotMoviesPage> {


   AsyncMemoizer<MovieListEntity> _memoizer = AsyncMemoizer();

  Future<MovieListEntity> _requestMoreHotMovies(cityName) async {
    var response =
        await DioUtil.getInstance().get(ApiService.GET_MOVIES, data: {
      'city': cityName,
      'start': '16',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  Future<MovieListEntity> _requestOnce(cityName) async {
    return _memoizer.runOnce(()async{
      return _requestMoreHotMovies(cityName);
    });
  }


  Future<void> _onRefresh()async{
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
        body: StoreConnector<GlobalState,City>(
         converter: (store)=>store.state.city,
         builder: (context,city){
           return FutureBuilder<MovieListEntity>(
               future: _requestOnce(city.name),
               builder: (BuildContext context, AsyncSnapshot<MovieListEntity> snapshot) {
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
         },
        )
    );
  }
}
