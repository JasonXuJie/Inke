import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';

class HotMovieList extends StatelessWidget {
  List<dynamic> movieList;
  HotMovieList({Key key, @required this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length == 0 ? 0 : movieList.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context, movieList[position]);
        });
  }

  _buildItem(context, Subjects subjects) {
    var _item = Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      width: 130.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            subjects.images.medium,
            width: 80.0,
            height: 120.0,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              subjects.title,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
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
