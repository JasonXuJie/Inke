import 'package:flutter/material.dart';
import 'package:Inke/widgets/dialog_loading.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/widgets/bottom_picker_view.dart';
import 'package:Inke/util/toast.dart';
class MyInfoSettingPage extends StatefulWidget {

  var name;

  MyInfoSettingPage({Key key, @required this.name})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyInfoSettingPage> {

  final TextEditingController _nameController = TextEditingController();
  List<String> gender = ['男', '女'];
  var _selectGender;

  @override
  void initState() {
    super.initState();
    _nameController.value =
        TextEditingValue(text: widget.name.isEmpty ? '' : widget.name);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
              padding: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                )),
              ),
              child: TextField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                onChanged: (String value) {
                  widget.name = value;
                },
                decoration: InputDecoration.collapsed(
                    hintText: '请输入昵称',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '性别',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  FlatButton(
                    child: Text(
                      _selectGender == null ? '请选择' : _selectGender,
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                    onPressed: () {
                      _showPicker();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  submit(context);
                },
                child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit(context) {
    if (widget.name.isEmpty) {
      Toast.show('请填写数据');
      return;
    }
    _showLoading(context);
    SharedUtil.getInstance().put(SharedKey.USER_NAME, widget.name);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      if (Navigator.canPop(context)) {
        List<String> info = [widget.name];
        RouteUtil.pop(context, result: info);
      }
    });
  }

  _showLoading(context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(text: '加载中....');
        });
  }

  _showPicker() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return PickerView(data: gender, callBack: (item){
            setState(() {
              _selectGender =item;
            });
          });
        });
  }
}
