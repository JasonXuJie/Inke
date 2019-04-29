import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/components/loading_view.dart';
import 'package:Inke/module_my/history_list_view.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/bean/history_list_result_entity.dart';

import 'package:Inke/http/http_manager_jh.dart';

class TodayInHistoryPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TodayInHistoryPage> {
  var date = DateTime.now();
  List<HistoryListResult> data;

  Future<Null> _requestData({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        this.data = null;
      });
    }
    var response = await HttpManager.getInstance()
        .get(ApiService.getTodayList, params: {
      'key': ApiService.historyKey,
      'date': '${date.month}/${date.day}'
    });
    var data = HistoryListEntity.fromJson(response);
    setState(() {
      this.data = data.result;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer();
  }

  Widget _buildContainer() {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('历史上的今天'),
          centerTitle: true,
        ),
        body: LoadingView(),
      );
    } else {
      return Scaffold(
          body: RefreshIndicator(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text('历史上的今天'),
                    centerTitle: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        AppImgPath.mainPath + 'history_bg.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    pinned: true,
                  ),
                  HistoryList(data: data),
                ],
              ),
              onRefresh: () => _requestData(isRefresh: true)));
    }
  }
}
