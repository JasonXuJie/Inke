import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  TextEditingController _editController = TextEditingController();
  var _searchValue = '';
  List<String> _searchTips = [
    '周杰伦',
    'supreme',
    'kenzo',
    '抖音',
    '小米',
    'ios',
    '手机',
    'ios',
    '安卓'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: TextField(
              controller: _editController,
              decoration: InputDecoration(
                hintText: '请输入搜索内容',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              maxLines: 1,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _searchValue = value;
              },
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            InputChip(
              onPressed: () {},
              label: Text(
                '搜索',
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '搜索提示',
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Wrap(
                children: _buildSearchTips(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  '历史搜索',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> _buildSearchTips() {
    List<Widget> tipsChip = [];
    _searchTips.forEach((tips) {
      var chip = Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
          child: InputChip(
            label: Text(tips),
            backgroundColor: Colors.white,
            shape: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: () {
              print(tips);
            },
          ));
      tipsChip.add(chip);
    });
    return tipsChip;
  }
}
