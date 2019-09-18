import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/bean/history_list_result_entity.dart';
import 'package:Inke/widgets/widget_my_future.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/module_my/page_history_details.dart';
import 'package:Inke/config/route_config.dart';

class TodayInHistoryPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TodayInHistoryPage> {

  final date = DateTime.now();

  Future<void> _onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('历史上的今天'),
              centerTitle: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: loadAssetImage('history_bg',
                    format: 'jpeg', fit: BoxFit.cover),
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: FutureBuilderWidget(
                loadFuture: Api.getHistoryList('${date.month}/${date.day}'),
                loadingWidget: LoadingView(),
                defaultErrorCallback: () {
                  setState(() {});
                },
                buildDataWidget: _DataWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<HistoryListResult> data;

  HistoryList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context, data[position]);
        });
  }

  _buildItem(context, HistoryListResult itemData) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(itemData.title),
          subtitle: Text(itemData.date),
          leading: Icon(
            Icons.history,
            size: 30.0,
            color: Colors.blue,
          ),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            RouteUtil.pushWidget(
                context,
                HistoryDetailsPage(
                  e_id: itemData.eId,
                  title: itemData.title,
                ));
          },
        ),
        Divider(
          height: 1.0,
        )
      ],
    );
  }
}

class _DataWidget extends DataWidget<HistoryListEntity> {
  @override
  Widget buildContainer(HistoryListEntity data) {
    return HistoryList(data: data.result);
  }
}
