import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Inke/bean/dream_result_entity.dart';

class DreamList extends StatelessWidget {

  final List<DreamResult> data;

  DreamList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(data[index]);
        });
  }

  _buildItem(DreamResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 15.0),
          child: Text(
            '标题:${data.title}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 25.0),
          child: Text(
            '类型:${data.type}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
        ),
        Html(
          data: data.content,
          padding: const EdgeInsets.only(left: 25.0, top: 15.0),
          defaultTextStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Divider(),
        )
      ],
    );
  }
}
