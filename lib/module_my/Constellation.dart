import 'package:flutter/material.dart';
import '../Api.dart';
import '../util/DioUtil.dart';
import '../components/LoadingView.dart';
import '../util/ToastUtil.dart';
import '../bean/consellation_data.dart';
import 'dart:async';

class ConstellationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConstellationState();
}

class _ConstellationState extends State<ConstellationPage> {
  String _value;
  var map = {
    '今日运势': false,
    '明日运势': false,
    '本周运势': false,
    '本月运势': false,
    '本年度运势': false,
  };
  var isSelected = false;
  var type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('星座运势'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '请输入你的星座例如:白羊座',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 15.0),
              maxLines: 1,
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                _value = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              children: _buildChips(),
            ),
          ),
          _buildContainer()
        ],
      ),
    );
  }

  _buildChips() {
    List<Widget> chips = [];
    map.forEach((title, select) {
      var chip = Padding(
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
            label: Text(title),
            selected: map[title],
            selectedColor: Colors.green,
            disabledColor: Colors.red,
            onSelected: (isSelected) {
              map.forEach((label, selectState) {
                if (label == title) {
                  setState(() {
                    map[label] = true;
                    switch (label) {
                      case '今日运势':
                        type = 'today';
                        break;
                      case '明日运势':
                        type = 'tomorrow';
                        break;
                      case '本周运势':
                        type = 'week';
                        break;
                      case '本月运势':
                        type = 'month';
                        break;
                      case '本年度运势':
                        type = 'year';
                        break;
                    }
                  });
                  if (_value == null || _value.trim().length == 0) {
                    ToastUtil.showShortToast('请填写您的星座');
                    return;
                  } else {
                    _requestData();
                  }
                } else {
                  map[label] = false;
                }
              });
            }),
      );
      chips.add(chip);
    });
    return chips;
  }

  Future<consellationData> _requestData() async {
    var response =
        await DioUtil.getAfdInstance().get(ApiService.CONSTELLATION, data: {
      'key': ApiService.CONSTELLATION_KEY,
      'consName': _value,
      'type': type,
    });
    return consellationData.fromJson(response);
  }

  _buildContainer() {
    if (_value != null && type != null) {
      return Expanded(
          child: FutureBuilder<consellationData>(
        future: _requestData(),
        builder:
            (BuildContext context, AsyncSnapshot<consellationData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return LoadingView();
              break;
            default:
              {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error.toString()}'),
                  );
                } else {
                  if (snapshot.data.result1 == null) {
                    return Center(
                      child: Text('暂无收到结果'),
                    );
                  } else {
                    return _buildContent(snapshot.data.result1);
                  }
                }
              }
          }
        },
      ));
    } else {
      return Container();
    }
  }

  _buildContent(Result1 data) {
    var dateVisible = data.datetime == null ? true : false;
    var allVisible = data.all == null ? true : false;
    var colorVisible = data.color == null ? true : false;
    var healthVisible = data.health == null ? true : false;
    var loveVisible = data.love == null ? true : false;
    var moneyVisible = data.money == null ? true : false;
    var numVisible = data.number == null ? true : false;
    var friendVisible = data.qFriend == null ? true : false;
    var workVisible = data.work == null ? true : false;
    var summoryVisible = data.summary == null ? true : false;
    print(data.datetime == null);
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 15.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Offstage(
              offstage: dateVisible,
              child: Text(
                '日期:${data.datetime}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Offstage(offstage: allVisible, child: _buildItem('综合:${data.all}')),
            Offstage(
                offstage: colorVisible, child: _buildItem('幸运色:${data.color}')),
            Offstage(
                offstage: healthVisible,
                child: _buildItem('健康:${data.health}')),
            Offstage(
                offstage: loveVisible, child: _buildItem('爱情:${data.love}')),
            Offstage(
                offstage: moneyVisible, child: _buildItem('金钱:${data.money}')),
            Offstage(
                offstage: numVisible, child: _buildItem('幸运数字:${data.number}')),
            Offstage(
                offstage: friendVisible,
                child: _buildItem('匹配星座:${data.qFriend}')),
            Offstage(
                offstage: workVisible, child: _buildItem('工作:${data.work}')),
            Offstage(
                offstage: summoryVisible,
                child: _buildItem('总结:${data.summary}')),
          ],
        ));
  }

  _buildItem(text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }
}
