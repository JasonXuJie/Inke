import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBackPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户反馈'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10.0,
          children: <Widget>[
            Text('请将您的反馈填写下处，我们会及时收到'),
            TextField(
              decoration: InputDecoration(
                  hintText: '请填写此处',
                  hintStyle: TextStyle(color: const Color(0xFF808080)),
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0)))),
              maxLines: 6,
              maxLength: 150,
              controller: _controller,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    '提交',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
