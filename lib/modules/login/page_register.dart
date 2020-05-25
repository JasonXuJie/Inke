import 'package:flutter/material.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RegisterPage> {
  Timer _timer;
  int _countdownTime = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  var _phone = '';
  var _code = '';
  @override
  void initState() {
    super.initState();
    _phoneController.value = TextEditingValue(text: _phone);
    _codeController.value = TextEditingValue(text: _code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('注册'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入手机号',
                    hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    )),
                onChanged: (String value){
                  _phone = value;
                },
              ),
            ),
            Divider(height: 1.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入验证码',
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          )),
                      keyboardType: TextInputType.number,
                      onChanged: (String value){
                        _code = value;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (_countdownTime == 0) {
                          setState(() {
                            _countdownTime = 60;
                          });
                          startCountdownTimer();
                        }
                      },
                      child: Text(
                        _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: _countdownTime > 0
                              ? Color.fromARGB(255, 183, 184, 195)
                              : Color.fromARGB(255, 17, 132, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,left: 30.0,right: 30.0),
              child: RaisedButton(
                  color: Colors.blue,
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text('获取验证码',style: const TextStyle(
                         color: Colors.white,
                        fontSize: 14.0,
                      ),),
                    ),
                  ),
                  onPressed: (){
                    print(_phone);
                    print(_code);
                  }),
            ),
          ],
        ));
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
