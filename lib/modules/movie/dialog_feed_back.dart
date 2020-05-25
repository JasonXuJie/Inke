import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FeedBackDialog extends StatelessWidget {

  final String title;

  FeedBackDialog({Key key,@required this.title}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400.0,
      color: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
                  child: RichText(text: TextSpan(
                    text: this.title,
                    style: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                    children: [
                      TextSpan(
                        text:'观影感受',
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ]
                  ))
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 1.0,
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                  child: RichText(
                    text: TextSpan(
                        text: '反馈',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: '(选择后将优化首页此类内容)',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: CupertinoColors.lightBackgroundGray,
                              )),
                        ]),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildButton('恐怖血腥', () {}),
                      _buildButton('色情低俗', () {})
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('封面恶心', () {}),
                    _buildButton('标题党/封面党', () {})
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                  child: RichText(
                      text: TextSpan(
                          text: '不感兴趣',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                        TextSpan(
                            text: '(选择后将减少相似内容推荐)',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: CupertinoColors.lightBackgroundGray,
                            ))
                      ])),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('剧情', () {}),
                    _buildButton('分区：电影', () {})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('频道:电影', () {}),
                    _buildButton('不感兴趣', () {})
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('取消',style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        ],
      ),
    );
  }

  _buildButton(String text, VoidCallback callBack) {
    return FlatButton(
        onPressed: callBack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(
              color: Colors.grey,
              width: 1.0,
            )),
        child: SizedBox(
          width: 100.0,
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
