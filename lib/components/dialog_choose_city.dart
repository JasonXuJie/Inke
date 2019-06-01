import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/bean/city_result_entity.dart';


typedef void OnSureCallBack(cityName,cityId);

///选择城市对话框
class ChooseCityDialog extends Dialog {
  final CityResultLoc city;
  final OnSureCallBack callBack;

  ChooseCityDialog(this.city,this.callBack);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200.0,
        child: Container(
          padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      text: '您所在的城市是否为',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                    TextSpan(
                      text: '${city.name}?',
                      style: const TextStyle(fontSize: 18.0, color: Colors.red),
                    )
                  ])),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.white,
                      highlightColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          )),
                      child: Text(
                        '取消',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      color: AppColors.color_0099fd,
                      highlightColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text('确定',
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                        callBack(city.name,city.id);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
