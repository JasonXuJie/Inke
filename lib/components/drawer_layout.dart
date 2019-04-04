import 'package:flutter/material.dart';

class DrawerLayout extends StatelessWidget {
  List titles = ['最新票房榜', '周公解梦', '历史上的今天', '反馈'];
  List icons = [
    Icons.star,
    Icons.settings,
    Icons.subject,
    Icons.account_balance
  ];

  @override
  Widget build(BuildContext context) {

    _buldItem(icon, label,index) {
      return InkWell(
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 25.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  label,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
        onTap: (){
            switch(index){
              case 0:
                Navigator.pushNamed(context, '/MoviesNewBo');
                break;
              case 1:
                Navigator.pushNamed(context, '/Dream');
                break;
              case 2:
                Navigator.pushNamed(context, '/Today');
                break;
              case 3:
                Navigator.pushNamed(context, '/FeedBack');
                break;
            }
        },
      );
    }

    List<Widget> _buildMenuList() {
      List<Widget> widgets = [];
      List.generate(titles.length, (index) {
        widgets.add(_buldItem(icons[index], titles[index],index));
      });
      return widgets;
    }

    return Container(
      constraints: BoxConstraints.expand(width: 300.0),
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(width: 300.0, height: 250.0),
            child: Center(
                child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 7.0,
              children: <Widget>[
                Text(
                  'Inke',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '版本号:1.0.0',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                )
              ],
            )),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: _buildMenuList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
