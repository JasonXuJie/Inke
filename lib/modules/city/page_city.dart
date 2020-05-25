import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/modules/city/dialog_choose_city.dart';
import 'package:Inke/bean/city_result_entity.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:provider/provider.dart';
import 'package:Inke/widgets/future_builder.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:Inke/widgets/app_bar.dart';
import 'package:Inke/widgets/loading.dart';

class CityPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=>_State();
}

class _State extends State<CityPage>{


  CityResultEntity data;

  @override
  void initState() {
    super.initState();
    Api.getCityList((result){
      if(mounted){
        setState(() {
          data = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.centerTitle('城市选择'),
      body:data == null? LoadingView() : GridView.count(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        crossAxisCount: 3,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 3.0,
        children: _renderItems(data.locs, context),
      )
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
                //Provider.of<CityProvider>(context).setName(cityName);
                //Provider.of<CityProvider>(context).setId(cityId);
                Provider.of<CityProvider>(context,listen: false).setCity(cityId, cityName);
                NavigatorUtil.goBack(context);
                //将值反船给上个界面
                //Navigator.of(context).pop(city.name);
              });
            });
      },
    );
  }

}
