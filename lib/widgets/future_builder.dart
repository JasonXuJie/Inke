import 'package:flutter/material.dart';
import 'package:Inke/widgets/loading.dart';
import 'package:Inke/widgets/widget_refresh.dart';

typedef BuildDataWidget<T> = Widget Function(T data);

class FutureContainer<T> extends StatelessWidget {
  final Future<T> future;
  final Widget loadingWidget;
  final Widget errorWidget;
  final BuildDataWidget<T> dataWidget;
  final Function refreshCallBack;

  FutureContainer(
      {@required this.future,
      @required this.dataWidget,
      this.loadingWidget,
      this.errorWidget,
      this.refreshCallBack})
      : assert(future != null),
        assert(dataWidget != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loadingWidget ?? LoadingView();
          default:
            if (snapshot.hasError) {
              return errorWidget ?? RefreshWidget(callback: refreshCallBack,);
            } else {
              return dataWidget(snapshot.data);
            }
        }
      },
    );
  }
}
