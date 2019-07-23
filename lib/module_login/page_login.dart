import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/util/string_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:Inke/util/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {

  var _phone = '';
  var _pwd = '';
  bool _isChecked = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() {
    _phoneController.value = TextEditingValue(text: _phone);
    _pwdController.value = TextEditingValue(text: _pwd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,///防止部件被键盘遮挡
        appBar: AppBar(
          title: Text('登陆'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                AppImgPath.mainPath + 'app_icon.png',
                width: 80.0,
                height: 80.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.black, hintColor: Colors.black),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '请输入手机号',
                          hintStyle: const TextStyle(
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
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.black),
                      onChanged: (String value) {
                        _phone = value;
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: '请输入密码',
                      hintStyle: const TextStyle(
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
                padding: const EdgeInsets.only(top: 15.0),
                child: CheckboxListTile(
                    value: _isChecked,
                    title: Text('记住账号',style: const TextStyle(color: Colors.black),),
                    controlAffinity: ListTileControlAffinity.leading,
                    selected: _isChecked,
                    onChanged: (isCheck) {
                      setState(() {
                        _isChecked = isCheck;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
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
                    onPressed: _login),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                      onPressed: () => RouteUtil.pushByNamed(
                          context, RouteConfig.registerName))),
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

  void _login() {
    if (StringUtil.isEmpty(_phone) || StringUtil.isEmpty(_pwd)) {
      Toast.show('请输入手机号或密码');
      return;
    }
    Provider.of<LoginProvider>(context).hasLogin(true);
    RouteUtil.pop(context);
  }
}
