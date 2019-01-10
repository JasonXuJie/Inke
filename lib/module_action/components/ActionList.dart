import 'package:flutter/material.dart';
import '../../util/SharedUtil.dart';
import '../../Api.dart';
import '../../bean/event.dart';
import '../../page/Web.dart';
import 'dart:async';
import '../../util/DioUtil.dart';
import 'package:event_bus/event_bus.dart';
import '../../event/CityChangedEvent.dart';
import '../../util/EventUtil.dart';
import '../../components/LoadingView.dart';
import '../../util/JumpUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/AppConfig.dart';
import '../../config/SharedKey.dart';
import '../../event/ScrollTopEvent.dart';
import '../../event/ChangeTypeEvent.dart';


class EventList extends StatefulWidget {
  String tag;

  EventList(this.tag);

  @override
  _State createState() => _State();
}

class _State extends State<EventList> {

  List<Events> events;
  ScrollController _controller = ScrollController();
  EventBus eventBus = EventBus();
  StreamSubscription mSubscription;

  @override
  void initState() {
    super.initState();
    _requestActions(widget.tag);
    mSubscription = EventUtil.getInstance().getEventBus().on().listen((event){
      if(event.runtimeType == CityChangedEvent){
        setState(() {
          events = null;
        });
        _requestActions(widget.tag);
      }else if(event.runtimeType == ScrollTopEvent){
        if(events!=null){
         _controller.jumpTo(0.0);
       }
      }else if(event.runtimeType == ChangeTypeEvent){
        setState(() {
          events = null;
        });
        _requestActions(widget.tag,datType:event.day_type);
      }
    });
  }

  @override
  void dispose() {
    mSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  _requestActions(type, {locId = '108296',datType = 'future'}) async {
    //print(datType);
    var id = SharedUtil.getInstance().get(SharedKey.CITY_ID,'108296');
    if (id != null) locId = id;
    var response = await DioUtil.getInstance().get(ApiService.GET_EVENTS,
        data: {'loc': locId, 'day_type': datType, 'type': type});
    var json = event.fromJson(response);
    setState(() {
      events = json.events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: getBody());
  }

  getBody() {
    if (events!= null) {
      return RefreshIndicator(
          child: ListView.builder(
              itemCount: events.length,
              controller: _controller,
              itemBuilder: (context,position)=>_buildItems(events[position])
          ),
          onRefresh: _refreshData);
    } else {
      return Center(child: LoadingView());
    }
  }

  Future<Null> _refreshData() async {
    _requestActions(widget.tag);
    return null;
  }

  _buildItems(Events event) {
    var icon = CachedNetworkImage(
        imageUrl: event.image,
        width: 100.0,
        height: 120.0,
        fit: BoxFit.cover,
        placeholder: Image.asset(AppImgPath.mainPath+'img_loading.jpeg',width: 100.0,height: 120.0,),
        errorWidget: Image.asset(AppImgPath.mainPath+'img_loading_error.png',width: 100.0,height: 120.0,),
    );
    var info = Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
            softWrap: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              '地点:${event.locName}',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              '地址:${event.address}',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              event.priceRange,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.red),
              softWrap: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('是否含门票:${event.hasTicket == false ? '否' : '是'}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('开始时间:${event.beginTime}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('结束时间:${event.endTime}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('已参与人数:${event.participantCount}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('想参加人数:${event.wisherCount}'),
          ),
        ],
      ),
    );
    var item = Container(
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
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
      margin: EdgeInsets.all(7.0),
      elevation: 10.0,
      child: InkWell(
        child: item,
        onTap: () {
          JumpUtil.push(context, Web(title: event.title, url: event.adaptUrl));
        },
      ),
    );
  }
}
