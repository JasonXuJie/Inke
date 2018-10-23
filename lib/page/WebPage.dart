import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

class WebPage extends StatefulWidget {
  final String url;

  WebPage({Key key, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebState();
}

class _WebState extends State<WebPage> {
  bool isLoaded = false;

  final _flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  GlobalKey<ScaffoldState> _webKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _onStateChanged = _flutterWebviewPlugin.onStateChanged.listen((state) {
      print('state:${state.type}');
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _flutterWebviewPlugin.close();
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    if (!isLoaded) {
      titleContent.add(CupertinoActivityIndicator());
    }
    titleContent.add(Text('Web'));
    return WebviewScaffold(
      key: _webKey,
      url: widget.url,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(icon: Icon(Icons.refresh), onPressed:_reload),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: _renderSharedDialog,
            ),
          ),
        ],
      ),
      withJavascript: true,
      withZoom: true,
      withLocalStorage: true,
    );
  }

  _reload(){
    setState(() {
      isLoaded = false;
    });
    _flutterWebviewPlugin.reload();
  }


  _renderSharedDialog() async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ConstrainedBox(
            constraints: BoxConstraints.expand(height: 300.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Align(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.expand(width: 60.0, height: 3.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 3.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: Text(
                            '分享到',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.expand(width: 60.0, height: 3.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 3.0,
                          ),
                        ),
                      ],
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/weixin_friend.png',
                              width: 60.0,
                              height: 60.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                '微信好友',
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/weixin_friendcycle.png',
                              width: 60.0,
                              height: 60.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                '朋友圈',
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/qq_friend.png',
                              width: 60.0,
                              height: 60.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                'QQ好友',
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/qq_area.png',
                              width: 60.0,
                              height: 60.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                'QQ空间',
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              '取消',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
