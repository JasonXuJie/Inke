import 'package:flutter/material.dart';
import 'package:Inke/module_my/page_history_details.dart';
import 'package:Inke/bean/history_list_result_entity.dart';
import 'package:Inke/util/route_util.dart';

class HistoryList extends StatelessWidget {
  final List<HistoryListResult> data;

  HistoryList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int position){
          return _buildItem(context, data[position]);
        }
    );
  }

  _buildItem(context, HistoryListResult itemData) {
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
            RouteUtil.pushByWidget(context, HistoryDetailsPage(
              e_id: itemData.eId,
              title: itemData.title,
            ));
          },
        ),
        Divider(
          height: 1.0,
        )
      ],
    );
  }
}
