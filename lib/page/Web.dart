import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

class Web extends StatefulWidget {

  final String url;
  final String title;

  Web({Key key, @required this.title, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebState();
}

class _WebState extends State<Web> {
  bool isLoaded = false;

  final _flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  GlobalKey<ScaffoldState> _webKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _onStateChanged = _flutterWebviewPlugin.onStateChanged.listen((state) {
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
    titleContent.add(Expanded(child: Text(widget.title,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    )));
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
            child: IconButton(icon: Icon(Icons.refresh), onPressed: _reload),
          ),
        ],
      ),
      withJavascript: true,
      withZoom: true,
      withLocalStorage: true,
    );
  }

  _reload() {
    setState(() {
      isLoaded = false;
    });
    _flutterWebviewPlugin.reload();
  }
}
