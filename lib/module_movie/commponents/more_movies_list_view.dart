import 'package:flutter/material.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/components/dialog_feed_back.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';

class MoreMovieList extends StatelessWidget {
  final List movieList;

  MoreMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext ctx, int index) {
            return _buildItem(context, movieList[index], index);
          },
          childCount: movieList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0,
        ));
  }

  _buildItem(context, MovieListSubject subject, int index) {
    var isEven = index.isEven;
    var item = Column(
      children: <Widget>[
        Expanded(
            child: Stack(
          children: <Widget>[
            Hero(
              tag: 'photo${subject.id}',
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: subject.images.medium,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0)),
              ),
              placeholderBuilder: (context,widget){
                print('placeholderBuilder');
                return Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.red,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '豆瓣评分:${subject.rating.average}',
                  style: const TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subject.title),
        ),
      ],
    );
    return Card(
      margin: EdgeInsets.only(
          left: isEven ? 10.0 : 0.0, right: isEven ? 0.0 : 10.0),
      elevation: 5.0,
      child: InkWell(
        child: item,
        onTap: () {
          RouteUtil.pushByWidget(
              context,
              MovieDetailsPage(
                id: subject.id,
              ));
        },
        onLongPress: (){
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return FeedBackDialog(title: subject.title);
              }
          );
        },
      ),
    );
  }
}
