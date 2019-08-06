import 'package:flutter/material.dart';
import 'package:Inke/widgets/dialog_loading.dart';
import 'package:Inke/widgets/widget_refresh.dart';


abstract class DataWidget<T> extends StatelessWidget{

  final T data;

  DataWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return buildContainer(data);
  }

  Widget buildContainer(T data);
}


class FutureBuilderWidget<T> extends StatefulWidget {

  final Widget loadingWidget;
  final Widget errorWidget;
  final DataWidget buildDataWidget;
  final Future<T> loadFuture;
  final Function defaultErrorCallback;

  FutureBuilderWidget({@required this.buildDataWidget,@required this.loadFuture,this.loadingWidget,this.errorWidget,this.defaultErrorCallback});

  @override
  _State createState() => _State<T>();
}

class _State<T> extends State<FutureBuilderWidget> {




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.loadFuture,
      builder: (BuildContext context,AsyncSnapshot<T> snapshot){
         switch(snapshot.connectionState){
           case ConnectionState.none:
             break;
           case ConnectionState.waiting:
           case ConnectionState.active:
             return widget.loadingWidget ?? LoadingDialog();
             break;
           case ConnectionState.done:
             if(snapshot.hasError){
                return widget.errorWidget ?? RefreshWidget(callback: widget.defaultErrorCallback,);
             }
             return widget.buildDataWidget.buildContainer(snapshot.data);
         }
      },
    );
  }
}
