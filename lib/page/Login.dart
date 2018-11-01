import 'package:flutter/material.dart';
import '../config/AppConfig.dart';
import '../util/ToastUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var _phone = '';
  var _pwd = '';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() {
    _phoneController.value = TextEditingValue(text: _phone ?? '');
    _pwdController.value = TextEditingValue(text: _pwd ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('登陆'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                AppImgPath.mainPath + 'app_icon.png',
                width: 80.0,
                height: 80.0,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.black, hintColor: Colors.black),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '请输入手机号',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                          ),
                          prefixIcon: Icon(Icons.phone),
                          border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 1.0,
                              ))),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      autofocus: false,
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      onChanged: (String value) {
                        _phone = value;
                      },
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: '请输入密码',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1.0,
                          ))),
                  keyboardType: TextInputType.text,
                  controller: _pwdController,
                  obscureText: true,
                  onChanged: (String value) {
                    _pwd = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
                child: RaisedButton(
                    color: Colors.blue,
                    child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            '登陆',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        )),
                    onPressed: _showLoginDialog),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: OutlineButton(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            '注册',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18.0),
                          ),
                        ),
                      ),
                      onPressed: () {})),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                        text: '注册即表示同意',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '用户协议',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                              ))
                        ]),
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  void _showLoginDialog() {
    if (_phone == '' || _pwd == '') {
      ToastUtil.showShortToast('请输入手机号或密码');
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('请检查输入的信息有误'),
            content: Wrap(
              direction: Axis.vertical,
              spacing: 15.0,
              children: <Widget>[
                Text('手机号:' + _phone),
                Text('密码:' + _pwd),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                textColor: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/Main');
                },
              )
            ],
          );
        });
  }
}
