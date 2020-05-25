import 'package:flutter/material.dart';
import 'package:Inke/util/string_util.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:Inke/util/toast.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';


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
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
          child: Column(
            children: <Widget>[
              loadAssetImage('app_icon',width: 80.0,height: 80.0),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: Colors.black, hintColor: Colors.black),
                    child:_buildEdit(Icons.phone, '请输入手机号', TextInputType.phone, false, _phoneController, (String value){
                      _phone = value;
                    }),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child:_buildEdit(Icons.lock, '请输入密码',  TextInputType.text, true, _pwdController, (String value){
                  _pwd = value;
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CheckboxListTile(
                    value: _isChecked,
                    title: Text('记住账号'),
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
                          child: Text('登陆',style: TextStyles.whiteNormal18,),
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
                          child: Text( '注册', style: TextStyles.blueNormal18,
                          ),
                        ),
                      ),
                      onPressed: () => NavigatorUtil.push(context, Routes.registered)
                  )),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(text: '注册即表示同意',style:TextStyles.blackNormal18,
                          children: <TextSpan>[
                            TextSpan(text: '用户协议',style:TextStyles.blueNormal18,)
                          ]),
                    ),
                  ),),
            ],
          ),
        ));
  }



  TextField _buildEdit(IconData icon,String hint,TextInputType type,bool obscure,TextEditingController controller,Function onChanged){
    return TextField(
      style: TextStyles.blackNormal18,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyles.greyNormal18,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 1.0,
              ))),
      keyboardType: type,
      controller: controller,
      obscureText: obscure,
      maxLines: 1,
      autofocus: false,
      onChanged: onChanged,
    );
  }

  void _login() {
    if (StringUtil.isEmpty(_phone) || StringUtil.isEmpty(_pwd)) {
      Toast.show('请输入手机号或密码');
      return;
    }
    Provider.of<LoginProvider>(context).hasLogin(true);
    NavigatorUtil.goBack(context);
  }
}
