import 'package:flutter/material.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/module_movie/dialog_feed_back.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';



class HotMovieList extends StatelessWidget {

  final List<MovieListSubject> movieList;

  HotMovieList({Key key, @required this.movieList}) : assert(movieList!=null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ...movieList.map((subject) {
            return _buildItem(context, subject);
          }).toList(),
          InkWell(
            onTap: () {
              RouteUtil.pushNamed(context, RouteName.moreHotMoviesName);
            },
            child: Container(
              width: 130,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.color_f5,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: Text('查看全部', style: TextStyles.greyNormal15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, MovieListSubject subjects) {
    var _item = Container(
      width: 130.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: 'photo${subjects.id}',
                  child: ClipRRect(
                      child: loadNetworkImage(subjects.images.medium,
                          width: 130.0, height: 140.0, fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0))),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                        child: Text(
                          '豆瓣评分:${subjects.rating.average}',
                          style: TextStyles.orangeBold11,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              subjects.title,
              style: TextStyles.blackNormal14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: InkWell(
        child: _item,
        onTap: () {
          RouteUtil.pushWidget(
              context,
              MovieDetailsPage(
                data: subjects,
              ));
        },
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FeedBackDialog(
                  title: subjects.title,
                );
              });
        },
      ),
    );
  }
}