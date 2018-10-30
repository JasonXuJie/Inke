import 'package:flutter/material.dart';
import '../Api.dart';
import '../page/Web.dart';
import 'dart:async';
import '../util/DioUtil.dart';
import '../bean/moviedetails.dart';
class MovieDetailsPage extends StatefulWidget {

  final String id;

  MovieDetailsPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {

  moviedetails details;


  @override
  void initState() {
    super.initState();
    _requestMovieDetails();
  }

  _requestMovieDetails() async {
    var response = await DioUtil.getInstance().get(ApiService.GET_MOVIE_DETAILS+widget.id);
    setState(() {
      details = moviedetails.fromJson(response);
    });
  }

  Future<Null> _refreshData() async {
    _requestMovieDetails();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('电影详情'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: getBody(),
    );
  }

  getBody() {
    if (details == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var scrollView = SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _buildMovieInfo(),
            _buildRating(),
            _buildDirectorsAndCasts(),
            _buildSummery(),
          ],
        ),
      );
      return RefreshIndicator(
          child: scrollView,
          onRefresh: _refreshData,
      );
    }
  }








  _buildMovieInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildMovieBasic(),
          InkWell(
            child: Image.network(
              details.images.medium,
              width: 140.0,
              height: 160.0,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Web(title:details.title,url: details.mobileUrl)));
            },
          ),
        ],
      ),
    );
  }

  _buildMovieBasic() {
    String aka = '';
    for (int i = 0; i < details.aka.length; i++) {
      aka += details.aka[i] + ' ';
    }
    String genres = '';
    for (int i = 0; i < details.genres.length; i++) {
      genres += details.genres[i] + ' ';
    }
    String countries = '';
    for (int i = 0; i < details.countries.length; i++) {
      countries += details.countries[i] + ' ';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          details.title,
          style: TextStyle(color: Colors.white, fontSize: 13.0),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: Text(
            aka,
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            genres,
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            countries,
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        )
      ],
    );
  }

  _buildRating() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '${details.rating.average}',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '评论人数:${details.commentsCount}',
                    style: TextStyle(color: Colors.grey, fontSize: 10.0),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${details.reviewsCount}',
                     style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    '评论个数',
                    style: TextStyle(color: Colors.grey, fontSize: 10.0),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${details.wishCount}',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    '想看人数',
                    style: TextStyle(color: Colors.grey, fontSize: 10.0),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                    ),
                    width: 170.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.remove_red_eye),
                        Text('我想看'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    width: 170.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.star),
                        Text('看过'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDirectorsAndCasts() {
    List data = [];
    for (int i = 0; i < details.directors.length; i++) {
      data.add(details.directors[i]);
    }
    for (int i = 0; i < details.casts.length; i++) {
      data.add(details.casts[i]);
    }
    var list = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int position) {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    data[position].avatars.small,
                    width: 80.0,
                    height: 100.0,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0),
                  child: Text(data[position].name,style: TextStyle(
                    fontSize: 13.0,
                  ),),),

                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Web(title:data[position].name,url: data[position].alt)));
              },
            ),
          );
        });
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              '演职人员',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150.0,
            child: list,
          )
        ],
      ),
    );
  }

  _buildSummery() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '剧情介绍',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
            child: Text(
              details.summary,
              style: TextStyle(color: Colors.black, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
