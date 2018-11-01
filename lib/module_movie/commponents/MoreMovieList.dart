import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';


class MoreMovieList extends StatelessWidget {

  List movieList;


  MoreMovieList({Key key, @required this.movieList}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return _buildItem(context, movieList[index]);
        },
            childCount: movieList.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        )
    );
  }

  _buildItem(context, Subjects subject) {
    var item = Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Wrap(
        direction: Axis.vertical,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5.0,
        children: <Widget>[
          Image.network(
            subject.images.medium,
            width: 120.0,
            height: 140.0,
            fit: BoxFit.cover,
          ),
          Text(subject.title),
          Text('评分:${subject.rating.average}', style: const TextStyle(
              color: Colors.orangeAccent
          ),),
        ],
      ),
    );
    return Card(
      margin: const EdgeInsets.all(0.0),
      elevation: 5.0,
      child: InkWell(
        child: item,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsPage(
                        id: subject.id,
                      )));
        },
      ),
    );
  }

}