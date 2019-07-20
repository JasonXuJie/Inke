import 'package:flutter/material.dart';
import 'package:Inke/bean/funItem.dart';
import 'package:oktoast/oktoast.dart';

class FunView extends StatelessWidget {

  final List<FunItem> items = [];


  FunView() {
    items.add(FunItem('热门预告片', '精彩电影视频集锦', Colors.redAccent));
    items.add(FunItem('一日壹评', '每日推荐精彩影评论', Colors.greenAccent));
    items.add(FunItem('热议话题', '一起来讨论电影', Colors.blueAccent));
    items.add(FunItem('票票日签', '看经典电影台词', Colors.purpleAccent));
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return _buildItem(index);
        },
            childCount: items.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 2.0,
        )
    );
  }

  _buildItem(int index) {
    var item = items[index];
    var margin;
    switch(index){
      case 0:
        margin = const EdgeInsets.only(left: 10.0,top: 10.0);
        break;
      case 1:
        margin = const EdgeInsets.only(right: 10.0,top: 10.0);
        break;
      case 2:
        margin = const EdgeInsets.only(left: 10.0);
        break;
      case 3:
        margin = const EdgeInsets.only(right: 10.0);
        break;
    }
    return GestureDetector(
      onTap: ()=>showToast('功能暂未开通'),
      child: Opacity(
          opacity: 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: item.colors,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: margin,
            padding: const EdgeInsets.only(left:10.0,top: 20.0),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 5.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                Text(item.title, style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),),
                Text(item.subTitle, style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                )),
              ],
            ),
          ))
    );
  }

}