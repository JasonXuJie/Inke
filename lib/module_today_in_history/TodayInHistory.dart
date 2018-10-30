import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../bean/today_in_history.dart';
import 'dart:async';
import '../components/LoadingView.dart';
import 'components/HistoryList.dart';

class TodayInHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TodayInHistoryPage> {
  var date = DateTime.now();

  Future<todayInHistory> _requestData() async {
    var response = await DioUtil.getJhInstance()
        .get(ApiService.TODAY_IN_HISTORY, data: {
      'key': ApiService.HISTORY_KEY,
      'date': '${date.month}/${date.day}'
    });
    return todayInHistory.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('历史上的今天'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            child: FutureBuilder<todayInHistory>(
                future: _requestData(),
                builder: (BuildContext context,
                    AsyncSnapshot<todayInHistory> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return LoadingView();
                      break;
                    default:
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        print(snapshot.data.result.length);
                        return HistoryList(data: snapshot.data.result);
                      }
                  }
                }),
            onRefresh: _requestData));
  }
}
