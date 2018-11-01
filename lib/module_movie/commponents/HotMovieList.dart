import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';

class HotMovieList extends StatelessWidget {
  List<dynamic> movieList;

  HotMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length == 0 ? 0 : movieList.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildItem(context, movieList[position]);
            }));
  }

  _buildItem(context, Subjects subjects) {
    var _item = Container(
      padding: const EdgeInsets.only(top: 10.0, left: 15.0),
      width: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Image.network(
                  subjects.images.medium,
                  width: 120.0,
                  height: 140.0,
                  fit: BoxFit.fill,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, bottom: 3.0),
                        child: Text(
                          '豆瓣评分:${subjects.rating.average}',
                          style: const TextStyle(
                              color: Colors.orangeAccent, fontSize: 13.0),
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
      elevation: 5.0,
      margin: const EdgeInsets.all(5.0),
      child: InkWell(
        child: _item,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                        id: subjects.id,
                      )));
        },
      ),
    );
  }
}
