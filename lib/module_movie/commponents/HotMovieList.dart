import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';
import '../../util/JumpUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/AppConfig.dart';

class HotMovieList extends StatelessWidget {

  List<dynamic> movieList;

  HotMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length == 0 ? 0 : movieList.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildItem(context, movieList[position]);
            }));
  }

  _buildItem(context, Subjects subjects) {
    var _item = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: subjects.images.medium,
                    width: 130.0,
                    height: 140.0,
                    fit: BoxFit.fill,
                    placeholder: Image.asset(AppImgPath.loadingPath,width: 130.0,height: 140.0,),
                    errorWidget: Image.asset(AppImgPath.loadingErrorPath,width: 130.0,height: 140.0,),
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),topRight: Radius.circular(6.0))
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                        child: Text(
                          '豆瓣评分:${subjects.rating.average}',
                          style: const TextStyle(
                              color: Colors.orangeAccent, fontSize: 11.0),
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              subjects.title,
              style: const TextStyle(color: Colors.black, fontSize: 14.0),
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
        borderRadius: BorderRadius.all(Radius.circular(6.0))
      ),
      child: InkWell(
        child: _item,
        onTap: () {
          JumpUtil.push(context, MovieDetailsPage(id: subjects.id,));
        },
      ),
    );
  }
}
