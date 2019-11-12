import 'package:flutter/material.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/util/screen_util.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SearchPage> {
  TextEditingController _editController = TextEditingController();

  List<String> _data = ['搞笑', '爱情', '动作', '科技', '记录', '动漫', '犯罪', '战争'];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40.0,
            child: TextField(
              autofocus: true,
              controller: _editController,
              decoration: InputDecoration(
                hintText: '演员/电影名/类型/关键字',
                hintStyle: TextStyle(fontSize: 14.0, color: AppColors.color_9d),
                fillColor: AppColors.color_ff,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
              maxLines: 1,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontSize: 14.0, color: AppColors.color_66),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 28,
                ),
                onPressed: () {})
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0,left: 10.0),
              child: Text(
                '推荐搜索',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _buildRecommend(context),
            Padding(
              padding: const EdgeInsets.only(top: 14.0,left: 10.0),
              child: Text(
                '历史搜索',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  ///推荐搜索
  Widget _buildRecommend(context) {
    final screenWidth = ScreenUtil.getDeviceWidth(context) / 4;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Wrap(
        children: _data.map((item) {
          return Container(
            width: screenWidth,
            height: 40.0,
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FlatButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode()); //取消键盘
                    _editController.value = TextEditingValue(text: item);
                  },
                  color: AppColors.color_ff,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14.0, color: AppColors.color_9d),
                  )),
            ),
          );
        }).toList(),
      ),
    );
  }
}
