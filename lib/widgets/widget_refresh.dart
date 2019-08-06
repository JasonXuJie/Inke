import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/config/app_config.dart';

///比如服务器出错，网络异常等，可以手动进行刷新
class RefreshWidget extends StatelessWidget {

  final Function callback;

  RefreshWidget({this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          loadAssetImage('img_loading_error', width: 80.0, height: 80.0),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text('出错啦',style: TextStyles.blackNormal12, ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed:callback ?? (){},
                child: Container(
                   width: 100.0,
                   height: 40.0,
                   decoration: ShapeDecoration(
                       shape: OutlineInputBorder(borderSide: BorderSide(color: AppColors.colorPrimary,)),
                   ),
                  child: Center(
                    child: Text('重新加载',style: TextStyles.mainNormal14,),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
