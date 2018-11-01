import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../bean/today_in_history.dart';
import 'dart:async';
import '../components/LoadingView.dart';
import 'components/HistoryList.dart';
import '../config/AppConfig.dart';

class TodayInHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TodayInHistoryPage> {
  var date = DateTime.now();
  List<Result> data;

  Future<Null> _requestData({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        this.data = null;
      });
    }
    var response = await DioUtil.getJhInstance()
        .get(ApiService.TODAY_IN_HISTORY, data: {
      'key': ApiService.HISTORY_KEY,
      'date': '${date.month}/${date.day}'
    });
    var data = todayInHistory.fromJson(response);
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
