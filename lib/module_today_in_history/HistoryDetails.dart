import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../bean/historydetails.dart';
import '../components/LoadingView.dart';
import 'dart:async';
import '../config/AppConfig.dart';

class HistoryDetailsPage extends StatefulWidget {
  String e_id;
  String title;
  HistoryDetailsPage({Key key, @required this.e_id,@required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_DetailsState();
}


class _DetailsState extends State<HistoryDetailsPage> with TickerProviderStateMixin{
  
  TabController _controller;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
       ),
       body: FutureBuilder<historydetails>(
         future: _requesetDetails(),
         builder: (BuildContext context,AsyncSnapshot<historydetails> snapshot){
           switch(snapshot.connectionState){
             case ConnectionState.none:
             case ConnectionState.waiting:
               return LoadingView();
               break;
             default:
               if(snapshot.hasError){
                 return Text('${snapshot.error}');
               }else{
                 return _buildContent(snapshot.data.result[0]);
               }
           }
         },
       ),
     );
  }

  Future<historydetails> _requesetDetails()async{
    var response = await DioUtil.getJhInstance().get(ApiService.HISTORY_DETAILS,data: {
      'key':ApiService.HISTORY_KEY,
      'e_id':widget.e_id
    });
    return historydetails.fromJson(response);
  }

  _buildContent(Result data){
    _controller = TabController(length: data.picUrl.length, vsync: this);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 500.0,
            child: TabBarView(
              controller: _controller,
              children: _buildImages(data),
            ),
          ),
          Text(data.content)
        ],
      ),
    );
  }

  _buildImages(Result data){
    List<Widget> images = [];
    data.picUrl.forEach((picurl){
      var image =  FadeInImage.assetNetwork(
          placeholder: AppImgPath.mainPath+'app_icon.png',
          image: picurl.url,
          width: MediaQuery.of(context).size.width,
          height: 500.0,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 1200),
          fadeOutDuration: const Duration(milliseconds: 1200),
      );
      images.add(image);
    });
    return images;
  }

  @override
  void dispose() {
    if(_controller!=null)_controller.dispose();
    super.dispose();
  }
  
}