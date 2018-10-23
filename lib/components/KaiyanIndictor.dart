import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


//仿开眼tabbar下划线指示器
class KaiYanIndictor extends Decoration{
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) => _KaiYanIndictorPainter();

}

class _KaiYanIndictorPainter extends BoxPainter{

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color =Colors.black;
    paint.style = PaintingStyle.fill;
    final w = 7.0;
    final h = 3.0;
    canvas.drawRect(
      Rect.fromLTRB(offset.dx - w / 2 + configuration.size.width / 2,
          configuration.size.height - h, w, h), paint);
  }

}