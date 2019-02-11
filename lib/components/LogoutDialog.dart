import 'package:flutter/material.dart';
import '../config/AppConfig.dart';
import '../util/RouteUtil.dart';
import '../util/SharedUtil.dart';
import '../config/SharedKey.dart';
import '../config/RouteConfig.dart';

class LogoutDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200.0,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '提示',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    '您确定要登出吗?',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        decoration: TextDecoration.none),
                  ),
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                        RouteUtil.pop(context);
                    },
                    child: Text(
                      '取消',
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      SharedUtil.getInstance().put(SharedKey.IS_LOGIN, false);
                      RouteUtil.popAllAndPushByNamed(context,RouteConfig.LOGIN_PATH);
                    },
                    child: Text(
                      '确定',
                      style: const TextStyle(
                          color: Color(AppColors.colorPrimary),
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
