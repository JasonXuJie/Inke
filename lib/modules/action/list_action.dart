import 'package:Inke/config/shared_key.dart';
import 'package:Inke/provider/date_provider.dart';
import 'package:Inke/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/action_result_entity.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/future_builder.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:flustars/flustars.dart';


class ActionList extends StatefulWidget {

  final String type;
  final String dateType;

  ActionList({Key key, @required this.type,@required this.dateType}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<ActionList> with AutomaticKeepAliveClientMixin {

  ScrollController _controller = ScrollController();

  var _cityId;
  var _dateType = '';
  List<ActionResultEvent> dataList;

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    _cityId = Provider.of<CityProvider>(context,listen: false).id;
    _dateType = Provider.of<DateType>(context,listen: false).dateType;
    requestData();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() {
      dataList = null;
    });
    requestData();
  }

  requestData(){
    Api.getActionList(_cityId, _dateType, widget.type, (entity){
      if(mounted){
        setState(() {
          dataList = entity.events;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final changeCityId = Provider.of<CityProvider>(context,listen: false).id;
    final changeDateTYpe = Provider.of<DateType>(context,listen: false).dateType;
    if(_cityId != changeCityId){
      _cityId = changeCityId;
      setState(() {
        dataList = null;
      });
      requestData();
    }
    if(_dateType != changeDateTYpe){
      _dateType = changeDateTYpe;
      setState(() {
        dataList = null;
      });
      requestData();
    }
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.hasClients) {
            //_controller.jumpTo(10.0);
            _controller.animateTo(0.0,duration: Duration(milliseconds: 500),curve: Curves.ease);
          }
        },
        backgroundColor: AppColors.color_ff9900,
        isExtended: true,
        child: loadAssetImage('app_icon', width: 25.0, height: 25.0),
      ),
    );
  }

  _buildBody() {
    return dataList==null ? LoadingView():_buildList();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
          itemCount: dataList.length,
          controller: _controller,
          itemBuilder: (context, position) => _buildItems(dataList[position])),
    );
  }

  _buildItems(ActionResultEvent event) {
    var icon = loadNetworkImage(event.image, width: 100.0, height: 120.0);
    var info = Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
            softWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '地点:${event.locName}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '地址:${event.address}',
              style:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              event.priceRange,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.red),
              softWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('是否含门票:${event.hasTicket == false ? '否' : '是'}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('开始时间:${event.beginTime}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('结束时间:${event.endTime}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('已参与人数:${event.participantCount}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('想参加人数:${event.wisherCount}'),
          ),
        ],
      ),
    );
    var item = Container(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
      child: Row(
        children: <Widget>[
          icon,
          Expanded(
            child: info,
          ),
        ],
      ),
    );
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(7.0),
      elevation: 10.0,
      child: InkWell(
        child: item,
        onTap: () {
          print(event.adaptUrl);
          NavigatorUtil.push(context, '${Routes.web}?title=${Uri.encodeComponent(event.title)}&url=${Uri.encodeComponent(event.adaptUrl)}');
        },
      ),
    );
  }
}