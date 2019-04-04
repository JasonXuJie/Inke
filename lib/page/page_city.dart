import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/http/dio_util.dart';
import 'package:Inke/bean/city.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/components/dialog_choose_city.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/redux/global_state.dart';
import 'package:Inke/redux/city_reducer.dart';
import 'package:Inke/util/route_util.dart';


import 'package:Inke/bean/city_result_entity.dart';

class CityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('城市选择'),
        centerTitle: true,
      ),
      body: _renderBody(),
    );
  }

  Future<CityResultEntity> _getCity() async {
    var response = await DioUtil.getInstance().get(ApiService.GET_CITYS);
    return CityResultEntity.fromJson(response);
  }

  _renderBody() {
    return FutureBuilder<CityResultEntity>(
      future: _getCity(),
      builder: (BuildContext context, AsyncSnapshot<CityResultEntity> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return LoadingView();
            break;
          default:
            if (snapshot.hasError) {
              return Text('${snapshot.error.toString()}');
            } else {
              return GridView.count(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 3.0,
                children: _renderItems(snapshot.data.locs, context),
              );
            }
        }
      },
    );
  }

  _renderItems(citys, context) {
    List<Widget> widgets = List<Widget>();
    List.generate(citys.length, (position) {
      widgets.add(getItem(citys[position], context));
    });
    return widgets;
  }

  getItem(CityResultLoc city, context) {
    return GestureDetector(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              city.name,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
                return ChooseCityDialog(city,(cityName,cityId)async{
                  await SharedUtil.getInstance().put(SharedKey.cityName, city.name);
                  await SharedUtil.getInstance().put(SharedKey.cityId, city.id);
                  StoreProvider.of<GlobalState>(context).dispatch(UpdateCityAction(City(name: cityName,cityId: cityId)));
                  RouteUtil.pop(context);
                  //将值反船给上个界面
                  //Navigator.of(context).pop(city.name);
                });
            }
        );
      },
    );
  }
}
