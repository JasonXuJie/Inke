import 'package:flutter/material.dart';
import '../../bean/movie_new_bo.dart';

class NewBoList extends StatelessWidget {
  List<Result> data;

  NewBoList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
        });
  }

  _buildItem(index) {
    Result result = data[index];
    var textStyle;
    switch (result.rid) {
      case "1":
        textStyle = TextStyle(
            color: Colors.red, fontSize: 40.0, fontWeight: FontWeight.bold);
        break;
      case "2":
        textStyle = TextStyle(
            color: Colors.yellow, fontSize: 35.0, fontWeight: FontWeight.bold);
        break;
      case "3":
        textStyle = TextStyle(
            color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.bold);
        break;
      default:
        textStyle = TextStyle(color: Colors.grey, fontSize: 25.0);
    }
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(result.rid, style: textStyle),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        result.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '榜单周数:${result.wk}',
                    style: const TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '周末票房:${result.wboxoffice}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '累计票房:${result.tboxoffice}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
