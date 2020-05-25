import 'package:flutter/material.dart';
import 'package:Inke/util/toast.dart';
import 'package:Inke/widgets/text.dart';


class FunctionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return _buildItem(index);
        }, childCount: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 2.0,
        )
    );
  }

  _buildItem(int index) {
    var title;
    var content;
    var color;
    switch (index) {
      case 0:
        title = '热门预告片';
        content = '精彩电影视频集锦';
        color = Colors.redAccent;
        break;
      case 1:
        title = '一日壹评';
        content = '每日推荐精彩影评论';
        color = Colors.greenAccent;
        break;
      case 2:
        title = '热议话题';
        content = '一起来讨论电影';
        color = Colors.blueAccent;
        break;
      case 3:
        title = '票票日签';
        content = '看经典电影台词';
        color = Colors.purpleAccent;
        break;
    }
    return GestureDetector(
        onTap: () => Toast.show('功能暂未开通'),
        child: Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 5.0,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyles.whiteW700_16,
                  ),
                  Text(content, style: TextStyles.whiteNormal12),
                ],
              ),
            )));
  }
}