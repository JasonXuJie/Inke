import 'package:flutter/material.dart';
import 'package:Inke/components/loading_view.dart';
import 'dart:async';
import 'package:Inke/config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/components/bottom_picker_view.dart';
import 'package:Inke/bean/pairing_result_entity.dart';
import 'package:Inke/http/http_manager_afd.dart';
import 'package:Inke/util/toast.dart';
class PairingPage extends StatefulWidget {

  final bool flag;

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
                  Toast.show(widget.flag == true ? '请选择星座' : '请选择生肖');
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

  Future<PairingResultEntity> _requestConstellactionPairing() async {
    var response = await HttpManager.getInstance().get(ApiService.getPairing,
        params: {
          'key': ApiService.pairingKey,
          'xingzuo1': _value1,
          'xingzuo2': _value2
        });
    print(response);
    return PairingResultEntity.fromJson(response);
  }

  Future<PairingResultEntity> _requestChineseZodiac() async {
    var response =
        await HttpManager.getInstance().get(ApiService.getChinesePairing, params: {
      'key': ApiService.chinesePairingKey,
      'shengxiao1': _value1,
      'shengxiao2': _value2,
    });
    print(response);
    return PairingResultEntity.fromJson(response);
  }

  _buildContainer() {
    if (submit) {
      return Expanded(
          child: FutureBuilder<PairingResultEntity>(
              future: widget.flag == true
                  ? _requestConstellactionPairing()
                  : _requestChineseZodiac(),
              builder:
                  (BuildContext context, AsyncSnapshot<PairingResultEntity> snapshot) {
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

  _buildConstellationContent(PairingResult data) {
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
          return PickerView(data: list,callBack: (item){
            if (isValueSelect) {
              setState(() {
                _value1 = item;
              });
            } else {
              setState(() {
                _value2 = item;
              });
            }
          },);
        });
  }
}
