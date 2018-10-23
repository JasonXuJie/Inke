import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../components/LoadingView.dart';
import 'dart:async';
import '../config/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import '../Api.dart';
import '../util/ToastUtil.dart';
import '../bean/pairing_data.dart';

class PairingPage extends StatefulWidget {
  bool flag;

  PairingPage({Key key, @required this.flag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PairingPage> {
  var _value1;
  var _value2;
  var _placeHolder;
  final _placeHolderConsellations = '点击选择星座';
  final _placeHolderChineseZodiac = '点击选择生肖';
  var submit = false;

  List<String> consellations = [
    '白羊座',
    '金牛座',
    '双子座',
    '巨蟹座',
    '狮子座',
    '处女座',
    '天秤座',
    '天蝎座',
    '射手座',
    '魔蝎座',
    '水瓶座',
    '双鱼座'
  ];

  List<String> chineseZodiac = [
    '鼠',
    '牛',
    '虎',
    '兔',
    '龙',
    '蛇',
    '马',
    '羊',
    '猴',
    '鸡',
    '狗',
    '猪'
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    _value1 = widget.flag == true
        ? _placeHolderConsellations
        : _placeHolderChineseZodiac;
    _value2 = widget.flag == true
        ? _placeHolderConsellations
        : _placeHolderChineseZodiac;
    _placeHolder = widget.flag == true
        ? _placeHolderConsellations
        : _placeHolderChineseZodiac;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flag == true ? '星座配对' : '生肖配对'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _buildSelectView(true);
                  },
                  child: Text(
                    _value1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  AppImgPath.mainPath + 'app_icon.png',
                  width: 50.0,
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () {
                    _buildSelectView(false);
                  },
                  child: Text(
                    _value2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
            child: RaisedButton(
              onPressed: () {
                if (_value1 == _placeHolder || _value2 == _placeHolder) {
                  ToastUtil.showShortToast(
                      widget.flag == true ? '请选择星座' : '请选择生肖');
                } else {
                  setState(() {
                    submit = true;
                  });
                }
              },
              color: Colors.blue,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    '提交',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildContainer()
        ],
      ),
    );
  }

  Future<pairingData> _requestConstellactionPairing() async {
    var response = await DioUtil.getAfdInstance().get(ApiService.PAIRING,
        data: {
          'key': ApiService.PAIRING_KEY,
          'xingzuo1': _value1,
          'xingzuo2': _value2
        });
    print(response);
    return pairingData.fromJson(response);
  }

  Future<pairingData> _requestChineseZodiac() async {
    var response =
        await DioUtil.getAfdInstance().get(ApiService.CHINESE_PAIR, data: {
      'key': ApiService.CHINESE_PAIR_KEY,
      'shengxiao1': _value1,
      'shengxiao2': _value2,
    });
    print(response);
    return pairingData.fromJson(response);
  }

  _buildContainer() {
    if (submit) {
      return Expanded(
          child: FutureBuilder<pairingData>(
              future: widget.flag == true
                  ? _requestConstellactionPairing()
                  : _requestChineseZodiac(),
              builder:
                  (BuildContext context, AsyncSnapshot<pairingData> snapshot) {
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
                        if (snapshot.data.result == null) {
                          return Center(
                            child: Text('暂无数据'),
                          );
                        } else {
                          return _buildConstellationContent(
                              snapshot.data.result);
                        }
                      }
                    }
                }
              }));
    } else {
      return Container();
    }
  }

  _buildConstellationContent(Result data) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    data.content1,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    data.content2,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            )));
  }

  _buildSelectView(isValueSelect) async {
    var list = widget.flag == true ? consellations : chineseZodiac;
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 250.0,
              color: CupertinoColors.white,
              child: DefaultTextStyle(
                  style: const TextStyle(
                      color: CupertinoColors.black, fontSize: 22.0),
                  child: CupertinoPicker(
                      backgroundColor: CupertinoColors.white,
                      itemExtent: 50.0,
                      onSelectedItemChanged: (index) {
                        if (isValueSelect) {
                          setState(() {
                            _value1 = list[index];
                          });
                        } else {
                          setState(() {
                            _value2 = list[index];
                          });
                        }
                      },
                      children: List<Widget>.generate(list.length, (index) {
                        return Center(
                          child: Text(list[index]),
                        );
                      }))));
        });
  }
}
