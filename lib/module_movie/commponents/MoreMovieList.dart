import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';


class MoreMovieList extends StatelessWidget{

  List movieList;


  MoreMovieList({Key key,@required this.movieList}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          crossAxisCount: 2,
        ),
        scrollDirection: Axis.vertical,
        itemCount: movieList.length == 0 ? 0 : movieList.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context,movieList[position]);
        });
  }


  _buildItem(context,Subjects subject) {
    var item = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            subject.images.medium,
            width: 120.0,
            height: 140.0,
            fit: BoxFit.cover,
          ),
          Text(subject.title),
        ],
      ),
    );
    return Card(
      elevation: 5.0,
      child: InkWell(
        child: item,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                    id: subject.id,
                  )));
        },
      ),
    );
  }

}