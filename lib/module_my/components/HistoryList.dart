import 'package:flutter/material.dart';
import '../../bean/today_in_history.dart';
import '../HistoryDetails.dart';

class HistoryList extends StatelessWidget {
  List<Result> data;

  HistoryList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
        return _buildItem(ctx, data[index]);
      },childCount: data.length),
    );
  }

  _buildItem(context, Result itemData) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(itemData.title),
          subtitle: Text(itemData.date),
          leading: Icon(
            Icons.history,
            size: 30.0,
            color: Colors.blue,
          ),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HistoryDetailsPage(
                      e_id: itemData.eId,
                      title: itemData.title,
                    )));
          },
        ),
        Divider(
          height: 1.0,
        )
      ],
    );
  }
}
