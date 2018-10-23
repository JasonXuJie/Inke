import 'package:flutter/material.dart';
import '../components/LoadingView.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../bean/movie_new_bo.dart';
import 'dart:async';
import 'commponents/NewBoList.dart';

//最新票房
class MoviesNewBoPage extends StatelessWidget {
  Future<movieNewBo> _requestData() async {
    var response =
        await DioUtil.getAfdInstance().get(ApiService.MOVIE_BOX_OFFICE, data: {
      'key': ApiService.MOVIE_BOX_OFFICE_KEY,
      'area': 'CN',
    });
    return movieNewBo.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    _requestData();
    return Scaffold(
      appBar: AppBar(
        title: Text('最新票房'),
        centerTitle: true,
      ),
      body: FutureBuilder<movieNewBo>(
        future: _requestData(),
        builder: (BuildContext context, AsyncSnapshot<movieNewBo> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return LoadingView();
              break;
            default:
              if (snapshot.hasError) {
                return Text('${snapshot.error.toString()}');
              } else {
                return NewBoList(data: snapshot.data.result,);
              }
          }
        },
      ),
    );
  }
}
