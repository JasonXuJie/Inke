import 'package:flutter/material.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/app_config.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  static const List<Map<String, dynamic>> themeList = [
    {
      "color": 0xff937eff,
      "name": 'BlueViolet',
    },
    {
      "color": 0xff87CEFA,
      "name": 'LightSkyBlue',
    },
    {
      "color": 0xff48D1CC,
      "name": 'Teal',
    },
    {
      "color": 0xff00FF00,
      "name": 'Lime',
    },
    {
      "color": 0xffFF4500,
      "name": 'OrangeRed',
    },
    {
      "color": 0xffFF1493,
      "name": 'DeepPink',
    },
    {
      "color": 0xff40E0D0,
      "name": 'Turquoise',
    },
    {
      "color": 0xff008B8B,
      "name": 'DarkCyan',
    },
    {
      "color": 0xff1E90FF,
      "name": 'DoderBlue',
    },
    {
      "color": 0xffFF00FF,
      "name": 'Fuchsia',
    },
    {
      "color": 0xffFF1493,
      "name": 'DeepPink',
    },
    {
      "color": 0xff483D8B,
      "name": 'DarkSlateBlue',
    }
  ];

  @override
  void initState() {
    super.initState();
    final int itemLength = themeList.length;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: itemLength * 300));
    _animation = Tween(begin: 0.0, end: itemLength.toDouble())
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '主题',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 5 / 6,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  crossAxisCount: 3),
              itemCount: themeList.length,
              itemBuilder: (BuildContext context, int index) {
                final _theme = themeList[index];
                final animateValue = _getScaleValue(index);

                return Opacity(
                  opacity: animateValue,
                  child: Transform.scale(
                    scale: animateValue,
                    child: FlatButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {

                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(_theme['color']),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.elliptical(4, 4),
                                        topRight: Radius.elliptical(4, 4))),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              color: AppColors.white,
                              child: Text(
                                _theme['name'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(_theme['color']),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              })),
    );
  }

  double _getScaleValue(int index) {
    double value = _animation.value;
    if (value > index && value < index + 1) {
      return value - index;
    } else if (value >= index + 1) {
      return 1.0;
    }
    return 0.0;
  }
}
