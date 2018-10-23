import 'package:flutter/material.dart';
import '../util/ToastUtil.dart';
import '../components/LoadingDialog.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class MyInfoSettingPage extends StatefulWidget {
  var name;
  var motto;

  MyInfoSettingPage({Key key, @required this.name, @required this.motto})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MySettingState();
}

class _MySettingState extends State<MyInfoSettingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mottoController = TextEditingController();
  int _selectIndex = 0;
  FixedExtentScrollController _fixedController;
  List<String> gender = ['男', '女'];
  var _selectGender;

  @override
  void initState() {
    super.initState();
    _nameController.value =
        TextEditingValue(text: widget.name.isEmpty ? '' : widget.name);
    _mottoController.value =
        TextEditingValue(text: widget.motto.isEmpty ? '' : widget.motto);
    _fixedController = FixedExtentScrollController(initialItem: _selectIndex);
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
              margin: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 50.0),
              padding: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ))),
              child: TextField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: _mottoController,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                decoration: InputDecoration.collapsed(
                  hintText: '请输入您的座右铭',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
                ),
                onChanged: (String value) {
                  widget.motto = value;
                },
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
    if (widget.name.isEmpty || widget.motto.isEmpty) {
      ToastUtil.showShortToast('请填写数据');
      return;
    }

    _showLoading(context);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      if (Navigator.canPop(context)) {
        List<String> info = [widget.name, widget.motto];
        Navigator.of(context).pop(info);
      }
    });
  }

  _showLoading(context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingView(text: '加载中....');
        });
  }

  _showPicker() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 220.0,
            color: CupertinoColors.white,
            child: DefaultTextStyle(
                style: TextStyle(color: CupertinoColors.black, fontSize: 22.0),
                child: CupertinoPicker(
                    backgroundColor: CupertinoColors.white,
                    scrollController: _fixedController,
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectGender = gender[index];
                      });
                    },
                    children: List<Widget>.generate(gender.length, (int index) {
                      return Center(
                        child: Text(gender[index]),
                      );
                    }))),
          );
        });
  }
}
