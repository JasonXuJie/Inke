import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../util/SharedUtil.dart';
import '../bean/movie.dart';
import 'dart:async';
import '../components/LoadingView.dart';
import 'commponents/MoreHotMovieList.dart';

class MoreHotMoviesPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_MoreHotMoviesState();

}

class _MoreHotMoviesState extends State<MoreHotMoviesPage>{





  Future<movie> _requestData()async{
    var city = SharedUtil.getInstance().getCity()[SharedUtil.CITY_NAME];
    var response = await DioUtil.getInstance().get(ApiService.GET_MOVIES,data: {
      'city':city,
      'start':'16',
       'count':'20',
    });
    print(response);
   return movie.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('更多热门电影'),
         centerTitle: true,
       ),
       body: FutureBuilder<movie>(
           future: _requestData(),
           builder: (BuildContext context,AsyncSnapshot<movie> snapshot){
             switch(snapshot.connectionState){
               case ConnectionState.none:
               case ConnectionState.waiting:
                 return LoadingView();
                 break;
               default:
                 if(snapshot.hasError){
                   return Text('出现异常');
                 }else{
                   return MoreHotMoviesList(data: snapshot.data.subjects);
                 }
             }
           }),
     );
  }

}