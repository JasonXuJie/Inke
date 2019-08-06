import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:share/share.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/config/app_config.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
class WebPage extends StatefulWidget{

  final Map arguments;
  WebPage({this.arguments});

  @override
  State<StatefulWidget> createState()=> _State();

}



class _State extends State<WebPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  var _visible = false;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (ctx,snapshot){
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
                  title: Text(widget.arguments['title']),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(icon: Icon(Icons.refresh), onPressed: _reload),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(icon: Icon(Icons.share), onPressed:(){
                        _share();
                      }),
                    )
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    WebView(
                      initialUrl: widget.arguments['url'],
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
                    Visibility(
                        visible: _visible,
                        child: _buildContainer(),
                    )
                  ],
                )
            )
        );
      },
    );

  }

  _reload()async{
    var controller = await _controller.future;
    controller.reload();
  }

  _share() {
    setState(() {
      _visible = true;
    });
  }


  Widget _buildContainer(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _visible = false;
                  });
                },
                child: Container(color:AppColors.color_half_trans,),
              )
          ),
          _buildShare(),
        ],
      ),
    );
  }

  Widget _buildShare(){
    return Container(
      padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Padding(padding: const EdgeInsets.only(bottom: 15.0),child:Text('--分享到--',style: TextStyles.blackBold18,),),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(onPressed: (){
                      fluwx.share(fluwx.WeChatShareWebPageModel(
                          webPage: widget.arguments['url'],
                          title: widget.arguments['title'],
                          description: '这是一条分享',
                          scene: fluwx.WeChatScene.SESSION,
                          thumbnail: getImgPath('logo'),
                          transaction: "hh"
                        )
                      );
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            loadAssetImage('weixin_friend',width: 45.0,height: 45.0),
                            Padding(padding: const EdgeInsets.only(top: 5.0),child: Text('微信好友',style: TextStyles.blackNormal12,),),
                          ],
                        )
                    ),
                    FlatButton(onPressed: (){
                      fluwx.share(fluwx.WeChatShareWebPageModel(
                          webPage: widget.arguments['url'],
                          title: widget.arguments['title'],
                          description: '这是一条分享',
                          scene: fluwx.WeChatScene.TIMELINE,
                          thumbnail: getImgPath('logo'),
                          transaction: "hh"
                      ));
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            loadAssetImage('weixin_friendcycle',width: 45.0,height: 45.0),
                            Padding(padding: const EdgeInsets.only(top: 5.0),child: Text('微信呢朋友圈',style: TextStyles.blackNormal12,),),
                          ],
                        )
                    ),
                    FlatButton(onPressed: (){
                      setState(() {
                        _visible = false;
                      });
                      Share.share(widget.arguments['url']);
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            loadAssetImage('img_header',width: 45.0,height: 45.0),
                            Padding(padding: const EdgeInsets.only(top: 5.0),child: Text('系统分享',style: TextStyles.blackNormal12,),),
                          ],
                        )
                    ),
                  ],
                ),
            ),
            FlatButton(
                onPressed: (){
                  setState(() {
                    _visible = false;
                  });
                },
              child: Text('取消',style: TextStyles.blackNormal14,),
            )
        ],
      ),
    );
  }
}
