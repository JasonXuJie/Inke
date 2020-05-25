import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/history_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:Inke/widgets/loading.dart';

class HistoryListPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HistoryListPage> {

  final date = DateTime.now();

  List<HistoryListResult> result;

  @override
  void initState() {
    super.initState();
    Api.getHistoryListData('${date.month}/${date.day}',(data){
        if(mounted){
          setState(() {
            result = data.result;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('历史上的今天'),
            centerTitle: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: loadAssetImage('history_bg',format: 'jpeg', fit: BoxFit.cover),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: _buildContent()
          ),
        ],
      ),
    );
  }

  Widget _buildContent(){
    if(ObjectUtil.isEmptyList(result)){
      return LoadingView();
    }else{
      return HistoryList(data: result);
    }
  }

}

class HistoryList extends StatelessWidget {
  final List<HistoryListResult> data;

  HistoryList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context, data[position]);
        });
  }

  _buildItem(context, HistoryListResult itemData) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(itemData.title),
          subtitle: Text(itemData.date),
          leading: Icon(
            Icons.history,
            size: 30.0,
            color: Colors.blue,
          ),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            NavigatorUtil.push(context, '${Routes.historyDetail}?eId=${Uri.encodeComponent(itemData.eId)}&title=${Uri.encodeComponent(itemData.title)}');
          },
        ),
        Divider(
          height: 1.0,
        )
      ],
    );
  }
}
