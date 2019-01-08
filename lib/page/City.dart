import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Api.dart';
import '../util/SharedUtil.dart';
import '../util/DioUtil.dart';
import '../bean/citys.dart';
import 'package:event_bus/event_bus.dart';
import '../event/CityChangedEvent.dart';
import '../util/EventUtil.dart';
class CityPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<CityPage> {

  List<Locs> _citys = [];
  EventBus eventBus = EventBus();

  @override
  void initState() {
    super.initState();
    request();
  }

  request()async{
    var response = await DioUtil.getInstance().get(ApiService.GET_CITYS);
    var json =  citys.fromJson(response);
    setState(() {
      _citys = json.locs;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('城市'),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }

  getBody() {
    if (_citys.length != 0) {
    return GridView.count(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        crossAxisCount: 3,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 3.0,
        children: _renderItems(),
    );
    } else {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }


  _renderItems(){
    List<Widget> widgets = List<Widget>();
    List.generate(_citys.length, (position){
      widgets.add(getItem(_citys[position]));
    });
    return widgets;
  }


  getItem(Locs city) {
    return GestureDetector(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              city.name,
              style:const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ],
        ),
      ),
      onTap: () {
        SharedUtil.getInstance().saveCity(city.name, city.id).then((Null){
          EventUtil.getInstance().post(CityChangedEvent(Locs(city.parent, city.habitable, city.id, city.name, city.uid)));
          Navigator.of(context).pop(city.name);
        });
      },
    );
  }

}
