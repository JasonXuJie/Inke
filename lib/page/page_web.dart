import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';


class WebPage extends StatelessWidget {


  final Map arguments;
  WebPage({this.arguments});

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context,snapshot){
        return WillPopScope(
            onWillPop: ()async{
              if(snapshot.hasData){
                bool canGoBack = await snapshot.data.canGoBack();
                if(canGoBack){
                  //网页可返回时，优先返回上一页
                  snapshot.data.goBack();
                  return Future.value(false);
                }
                return Future.value(true);
              }
              return Future.value(true);
            },
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                  title: Text(arguments['title']),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(icon: Icon(Icons.refresh), onPressed: _reload),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(icon: Icon(Icons.share), onPressed: _share),
                    )
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    WebView(
                      initialUrl: arguments['url'],
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController controller) {
                        _controller.complete(controller);

                        controller.canGoBack().then((canBack) {
                          //print('canGoBack:$canBack');
                        });
                        controller.currentUrl().then((url) {
                          //print('currentUrl:$url');
                        });
                        controller.canGoForward().then((canForward) {
                          //print('canGoForward:$canForward');
                        });
                      },
                      onPageFinished: (String s) {
                        //print('onPageFinished:$s');
                      },
                    ),
                  ],
                ))
        );
      },
    );

  }

  _reload()async{
    var controller = await _controller.future;
    controller.reload();
  }

  _share() {
    Share.share(arguments['url']);
  }
}
