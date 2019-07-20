import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/util/event_util.dart';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/event/event_scroll_top.dart';
import 'package:async/async.dart';
import 'package:Inke/bean/action_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/provider/date_type_provider.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/image_util.dart';


class EventList extends StatefulWidget {

  final String type;

  EventList({Key key,@required this.type}):super(key:key);

  @override
  _State createState() => _State();
}

class _State extends State<EventList> with AutomaticKeepAliveClientMixin{

  ScrollController _controller = ScrollController();
  StreamSubscription mSubscription;
  AsyncMemoizer<ActionResultEntity> _memoizer = AsyncMemoizer();
  var _cityId;
  var _dateType;

  @override
  void initState() {
    super.initState();
    mSubscription = EventUtil.getInstance().getEventBus().on().listen((event){
      if(event.runtimeType == ScrollTopEvent) {
         if(_controller.hasClients){
           _controller.jumpTo(10.0);
         }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    mSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }


  Future<ActionResultEntity> _requestAction(cityId,dateType) async {
    var response = await HttpManager.getInstance().get(ApiService.GET_EVENTS,
        params: {'loc': cityId, 'day_type': dateType, 'type': widget.type});
    return ActionResultEntity.fromJson(response);
  }
  
  
  Future<ActionResultEntity> _request(cityId,dateType)async{
    if(_cityId == cityId && _dateType == dateType){
      return _memoizer.runOnce(()async{
         return _requestAction(cityId, dateType);
      });
    }else{
      _cityId = cityId;
      _dateType = dateType;
      return _requestAction(cityId, dateType);
    }
  }

  Future<void> _onRefresh()async{
    setState(() {
      _memoizer = AsyncMemoizer();
      _cityId = null;
      _dateType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  _buildBody();
  }



  _buildBody(){
    return Consumer2<CityProvider,DateTypeProvider>(
       builder: (context,CityProvider provider,DateTypeProvider dateType,_){
         return FutureBuilder<ActionResultEntity>(
           future: _request(provider.id, dateType.dateType),
           builder: (BuildContext context,AsyncSnapshot<ActionResultEntity> snapshot){
             switch(snapshot.connectionState){
               case ConnectionState.none:
               case ConnectionState.waiting:
                 return LoadingView();
                 break;
               default:
                 if(snapshot.hasError){
                   return Text('访问异常');
                 }else{
                   return RefreshIndicator(
                     onRefresh: _onRefresh,
                     child: ListView.builder(
                         itemCount: snapshot.data.events.length,
                         controller: _controller,
                         itemBuilder: (context,position)=>_buildItems(snapshot.data.events[position])
                     ),
                   );
                 }
             }
           },
         );
       },
    );
  }


  _buildItems(ActionResultEvent event) {
    var icon = loadNetworkImage(event.image,width: 100.0,height: 120.0);
//    var icon = CachedNetworkImage(
//        imageUrl: event.image,
//        width: 100.0,
//        height: 120.0,
//        fit: BoxFit.cover,
//        placeholder: (context,url)=>Image.asset(AppImgPath.mainPath+'img_loading.jpeg',width: 100.0,height: 120.0,),
//        errorWidget: (context,url,error)=>Image.asset(AppImgPath.mainPath+'img_loading_error.png',width: 100.0,height: 120.0,),
//    );
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
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
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
          RouteUtil.pushNamedByArgs(context, RouteConfig.webName, {'title':event.title,'url':event.adaptUrl});

        },
      ),
    );
  }


}
