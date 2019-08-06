import 'package:flutter/material.dart';
import 'package:Inke/widgets/gaps.dart';
import 'package:Inke/util/utils.dart';
class AuthorDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 300.0,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Utils.launchTelUrl('12345678');
                },
                child: Text('电话',style: TextStyle(color: Colors.black,fontSize: 20.0),),
              ),
              Gaps.vGap15,
              GestureDetector(
                onTap: () {
                  Utils.launchWebUrl();
                },
                child: Text('Github地址',style: TextStyle(color: Colors.black,fontSize: 20.0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
