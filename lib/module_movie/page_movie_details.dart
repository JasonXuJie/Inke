import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/page/page_web.dart';
import 'dart:async';
import 'package:Inke/util/route_util.dart';
import 'package:async/async.dart';
import 'package:Inke/components/loading_shimmer.dart';
import 'package:Inke/bean/movie_detail_result_entity.dart';
import 'package:Inke/http/http_manager.dart';

class MovieDetailsPage extends StatefulWidget {
  final String id;

  MovieDetailsPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MovieDetailsPage> {
  AsyncMemoizer<MovieDetailResultEntity> _memoizer = AsyncMemoizer();

  Future<MovieDetailResultEntity> _requestMovieDetails() async {
    var response = await HttpManager.getInstance()
        .get(ApiService.getMovieDetails + widget.id);
    return MovieDetailResultEntity.fromJson(response);
  }

  Future<MovieDetailResultEntity> _requestOnce() async {
    return _memoizer.runOnce(() async {
      return _requestMovieDetails();
    });
  }

  Future _onRefresh() async {
    setState(() {
      _memoizer = AsyncMemoizer();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('电影详情'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return FutureBuilder<MovieDetailResultEntity>(
      future: _requestOnce(),
      builder: (BuildContext context,
          AsyncSnapshot<MovieDetailResultEntity> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return ShimmerView();
            break;
          default:
            if (snapshot.hasError) {
              return Text('${snapshot.error.toString()}');
            } else {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _buildMovieInfo(snapshot.data),
                      _buildRating(snapshot.data),
                      _buildDirectorsAndCasts(snapshot.data),
                      _buildSummery(snapshot.data),
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }

  _buildMovieInfo(MovieDetailResultEntity details) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildMovieBasic(details),
          Hero(
            tag: 'photo${widget.id}',
            child: InkWell(
              child: Image.network(
                details.images.medium,
                width: 140.0,
                height: 160.0,
              ),
              onTap: () {
                RouteUtil.pushByWidget(
                    context, Web(title: details.title, url: details.mobileUrl));
              },
            ),
          )
        ],
      ),
    );
  }

  _buildMovieBasic(MovieDetailResultEntity details) {
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
          style: const TextStyle(color: Colors.white, fontSize: 13.0),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: Text(
            aka,
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            genres,
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            countries,
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        )
      ],
    );
  }

  _buildRating(MovieDetailResultEntity details) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
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
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
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
                    style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${details.reviewsCount}',
                    style: const TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    '评论个数',
                    style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${details.wishCount}',
                    style: const TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    '想看人数',
                    style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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

  _buildDirectorsAndCasts(MovieDetailResultEntity details) {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      data[position].name,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                RouteUtil.pushByWidget(context,
                    Web(title: data[position].name, url: data[position].alt));
              },
            ),
          );
        });
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '演职人员',
              style: const TextStyle(
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

  _buildSummery(MovieDetailResultEntity details) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '剧情介绍',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
            child: Text(
              details.summary,
              style: const TextStyle(color: Colors.black, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
