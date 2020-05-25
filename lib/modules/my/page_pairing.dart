import 'package:Inke/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/modules/my/view_picker.dart';
import 'package:Inke/bean/pairing_result_entity.dart';
import 'package:Inke/util/toast.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/app_bar.dart';
import 'package:Inke/widgets/text.dart';

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
  var _isVisible = false;
  PairingResultEntity data;
  ///星座选项
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
  ///生肖选项
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
    _value1 = widget.flag == true  ? _placeHolderConsellations  : _placeHolderChineseZodiac;
    _value2 = widget.flag == true ? _placeHolderConsellations  : _placeHolderChineseZodiac;
    _placeHolder = widget.flag == true  ? _placeHolderConsellations : _placeHolderChineseZodiac;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.centerTitle(widget.flag == true ? '星座配对' : '生肖配对'),
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
                  child: Text( _value1,style: TextStyles.blackBold18),
                ),
                loadAssetImage('app_icon',width: 50,height: 50),
                GestureDetector(
                  onTap: () {
                    _buildSelectView(false);
                  },
                  child: Text(_value2,style: TextStyles.blackBold18),
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
                  return;
                }
                setState(() {
                  _isVisible = true;
                });
                if(widget.flag == true){
                  ///星座请求
                  Api.getConstellactionPairing(_value1, _value2, (result){
                     if(mounted){
                       setState(() {
                         data = result;
                       });
                     }
                  });
                }else{
                  ///生肖请求
                  Api.getChineseZodiac(_value1, _value2, (result){
                    if(mounted){
                      setState(() {
                        data = result;
                      });
                    }
                  });
                }
              },
              color: Colors.blue,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text( '提交',style: TextStyles.whiteNormal18),
                ),
              ),
            ),
          ),
          _buildContainer()
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Visibility(
      visible: _isVisible,
      child: Expanded(
        child: data == null ? LoadingView() : _buildConstellationContent(data.result),
      ),
    );
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
                  child: Text( data.title,style: TextStyles.blackBold18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    data.content1,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.blackNormal14
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    data.content2,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.greyNormal15
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
          return PickerView(
            data: list,
            callBack: (item) {
              if (isValueSelect) {
                setState(() {
                  _value1 = item;
                });
              } else {
                setState(() {
                  _value2 = item;
                });
              }
            },
          );
        });
  }
}
