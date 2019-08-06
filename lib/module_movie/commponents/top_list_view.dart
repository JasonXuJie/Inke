import 'package:flutter/material.dart';
import 'package:Inke/module_movie//page_movie_details.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';

class TopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TopList> {

  var _refreshController = RefreshController();
  List<MovieListSubject> data=[];
  var start = 0;
  @override
  void initState() {
    super.initState();
    _requestTop250(start).then((movie){
      setState(() {
        data = movie.subjects;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      if(data.isEmpty){
        return LoadingView();
      }else{
        return SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: _onRefresh,
          headerBuilder: (context, mode) => _buildHeader(context, mode),
          footerBuilder: (context, mode) => _buildFooter(context, mode),
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

  _buildHeader(context, mode) {
    return new ClassicIndicator(
      mode: mode,
      height: 40.0,
      releaseText: '松开手刷新',
      refreshingText: '刷新中',
      completeText: '刷新完成',
      failedText: '刷新失败',
      idleText: '下拉刷新',
    );
  }

  _buildFooter(context, mode) {
    return new ClassicIndicator(
      mode: mode,
      height: 45.0,
      releaseText: '松开手加载',
      refreshingText: '加载中...',
      completeText: '加载完成',
      failedText: '加载失败',
      idleText: '无加载',
      noDataText: '再无更多数据...',
    );
  }

  ///下拉刷新和上拉加载回调
  _onRefresh(bool up) {
    if (up) {
       start = 0;
       _requestTop250(start).then((movie){
           setState(() {
             data = movie.subjects;
           });
           _refreshController.sendBack(up, RefreshStatus.completed);
           _refreshController.sendBack(false, RefreshStatus.canRefresh);
       });
    } else {
      start+=20;
      _requestTop250(start).then((movie){
        if(movie.subjects.length==0){
          _refreshController.sendBack(up, RefreshStatus.noMore);
        }else{
          setState(() {
            data.addAll(movie.subjects);
          });
          _refreshController.sendBack(up, RefreshStatus.canRefresh);
        }
      });
    }
  }

  Future<MovieListEntity> _requestTop250(int start) async {
    var response =
        await HttpManager.getInstance().get(ApiService.getTop250, params: {
      'start': '$start',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + ' ';
    });
    return InkWell(
      onTap: () {
        RouteUtil.pushByWidget(
            context,
            MovieDetailsPage(
              data: itemData,
            ));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 0.0),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child:loadFadeInNetImage(itemData.images.medium,width: 120.0,height: 80.0,placeholder: 'app_icon'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                itemData.title,
                style: TextStyles.blackBold16
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '类型:' + genres,
                style: TextStyles.blackNormal14
              ),
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
              child: Text(
                '评分:${itemData.rating.average}',
                style: TextStyles.blackNormal14
              ),
            ),
          ],
        ),
      ),
    );
  }
}
