import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/widgets/dialog_choose_city.dart';
import 'package:Inke/bean/city_result_entity.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:provider/provider.dart';
import 'package:Inke/config/route_config.dart';

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

  _renderBody() {
    return FutureBuilder<CityResultEntity>(
      future: Api.getCityList(),
      builder:
          (BuildContext context, AsyncSnapshot<CityResultEntity> snapshot) {
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
            builder: (context) {
              return ChooseCityDialog(city, (cityName, cityId) async {
                Provider.of<CityProvider>(context).setName(cityName);
                Provider.of<CityProvider>(context).setId(cityId);
                RouteUtil.pop(context);
                //将值反船给上个界面
                //Navigator.of(context).pop(city.name);
              });
            });
      },
    );
  }
}
