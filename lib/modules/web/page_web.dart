import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:share/share.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/fluwx_util.dart';

class WebPage extends StatefulWidget {

  final String title;
  final String url;
  WebPage({@required this.title,@required this.url});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WebPage> {
  WebViewController _webViewController;
  Completer<bool> _finishCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return WillPopScope(
        onWillPop: () async {
          bool canGoBack = await _webViewController.canGoBack();
          if (canGoBack) {
            //网页可返回时，优先返回上一页
            _webViewController.goBack();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
            appBar: _renderWebAppBar(),
            body: Stack(
              children: <Widget>[
                WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {
                    ///TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
                    return NavigationDecision.navigate;
                  },
                  onWebViewCreated: (WebViewController controller) {
                    _webViewController = controller;
                    controller.currentUrl().then((url) {
                      debugPrint('返回当前$url');
                    });
                  },
                  onPageFinished: (String s) {
                    if (!_finishCompleter.isCompleted)
                      _finishCompleter.complete(true);
                    //print('onPageFinished:$s');
                  },
                ),
                FutureBuilder<bool>(
                  future: _finishCompleter.future,
                  initialData: false,
                  builder: (context, snapshot) {
                    return Offstage(
                      offstage: snapshot.data,
                      child: LinearProgressIndicator(),
                    );
                  },
                )
              ],
            )));
  }

  AppBar _renderWebAppBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          FutureBuilder<bool>(
            future: _finishCompleter.future,
            initialData: false,
            builder: (context, snapshot) {
              return Offstage(
                offstage: snapshot.data,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CupertinoActivityIndicator(),
                ),
              );
            },
          ),
          Expanded(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
      leading: GestureDetector(
        onTap: () async {
          bool canGoBack = await _webViewController.canGoBack();
          if (canGoBack)
            _webViewController.goBack();
          else
            Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await _webViewController.reload();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                showShareDialog(context);
              }),
        )
      ],
    );
  }

  showShareDialog(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    '--分享到--',
                    style: TextStyles.blackBold18,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            FluWxUtil.share(widget.url,
                                widget.title, true);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              loadAssetImage('weixin_friend',
                                  width: 45.0, height: 45.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '微信好友',
                                  style: TextStyles.blackNormal12,
                                ),
                              ),
                            ],
                          )),
                      FlatButton(
                          onPressed: () {
                            FluWxUtil.share(widget.url,
                                widget.title, false);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              loadAssetImage('weixin_friendcycle',
                                  width: 45.0, height: 45.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '微信至朋友圈',
                                  style: TextStyles.blackNormal12,
                                ),
                              ),
                            ],
                          )),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Share.share(widget.url);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              loadAssetImage('img_header',
                                  width: 45.0, height: 45.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '系统分享',
                                  style: TextStyles.blackNormal12,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消',
                    style: TextStyles.blackNormal14,
                  ),
                )
              ],
            ),
          );
        });
  }
}
