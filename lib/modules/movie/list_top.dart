import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/widgets/loading.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';



class TopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TopList> with AutomaticKeepAliveClientMixin{

  var _refreshController = RefreshController();

  List<MovieListSubject> data = [];
  var start = 0;

  @override
  void initState() {
    super.initState();
    Api.getTop250(start, (entity){
      if(mounted){
        setState(() {
          data = entity.subjects;
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (data.isEmpty) {
      return LoadingView();
    } else {
      return SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _refreshController,
        child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return _buildItem(context, data[index]);
            }),
      );
    }
  }

  ///下拉刷新
  _onRefresh() {
    start = 0;
    Api.getTop250(start, (entity){
      if(mounted){
        setState(() {
          data = entity.subjects;
        });
        _refreshController.refreshCompleted();
      }
    });
  }

  //上拉加载
  _onLoading() {
    start += 20;
    Api.getTop250(start, (entity){
       if(entity.subjects.length == 0) {
         _refreshController.loadNoData();
       }else{
         setState(() {
           data.addAll(entity.subjects);
         });
         _refreshController.loadComplete();
       }
    });
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + ' ';
    });
    return InkWell(
      onTap: () {
        NavigatorUtil.push(context, '${Routes.movieDetails}?id=${Uri.encodeComponent(itemData.id)}'
            '&title=${Uri.encodeComponent(itemData.title)}&image=${Uri.encodeComponent(itemData.images.medium)}');
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 0.0),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: loadFadeInNetImage(itemData.images.medium,
                  width: 120.0, height: 80.0, placeholder: 'app_icon'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(itemData.title, style: TextStyles.blackBold16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text('类型:' + genres, style: TextStyles.blackNormal14),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '上映时间:${itemData.year}',
                style: TextStyles.blackNormal14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text('评分:${itemData.rating.average}',
                  style: TextStyles.blackNormal14),
            ),
          ],
        ),
      ),
    );
  }


}