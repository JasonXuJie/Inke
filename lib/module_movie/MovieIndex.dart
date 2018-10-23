import 'package:flutter/material.dart';
import '../Api.dart';
import '../components/BannerView.dart';
import '../components/DrawerLayout.dart';
import '../util/SharedUtil.dart';
import '../util/DioUtil.dart';
import '../bean/movie.dart';
import 'commponents/HotMovieList.dart';
import 'commponents/MoreMovieList.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class MovieFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<MovieFragment> {
  List<Subjects> _movieList = [];
  var cityName = '';

  @override
  void initState() {
    super.initState();
    _requestMovies();
    _getCityName();
  }

  _requestMovies({String cityName = '上海'}) async {
    var response = await DioUtil.getInstance().get(ApiService.GET_MOVIES,
        data: {'city': cityName, 'start': '0', 'count': '15'});
    var json = movie.fromJson(response);
    setState(() {
      _movieList = json.subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/Search'),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    '请输入要搜索的内容',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[_buildPopMenu()],
      ),
      drawer: DrawerLayout(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (_movieList.length != 0) {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          BannerView(
            dataList: _movieList,
          ),
          _buildTitle('热门电影'),
          Container(
            height: 200.0,
            child: HotMovieList(movieList: _movieList),
          ),
          _buildTitle('更多电影'),
          MoreMovieList(
            movieList: _movieList,
          ),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  _getCityName() {
    var name = SharedUtil.getInstance().getCity()[SharedUtil.CITY_NAME];
    cityName = name == null ? '上海' : name;
  }

  _buildPopMenu() {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert),
      onSelected: (int value) {
        switch (value) {
          case 0:
            scan();
            break;
          case 1:
            Navigator.pushNamed(context, '/City').then((result) {
              setState(() {
                cityName = result;
                _requestMovies(cityName: cityName);
              });
            });
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: <Widget>[Icon(Icons.scanner), Text('扫一扫')],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: <Widget>[Icon(Icons.location_city), Text(cityName)],
              ),
            ),
          ],
    );
  }

  _buildTitle(String label) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                color: Colors.orange[800],
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            child: Text(
              '更多',
              style: TextStyle(color: Colors.grey[500], fontSize: 13.0),
            ),
            onTap: () {
              switch (label) {
                case '热门电影':
                  Navigator.pushNamed(context, '/MoreHotMovies');
                  break;
                case '更多电影':
                  Navigator.pushNamed(context, '/MoreMovies');
                  break;
              }
            },
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String result = await BarcodeScanner.scan();
      print(result);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('The user did not grant the camera permission!');
      } else {
        print('Unknown error: $e');
      }
    } on FormatException {
      print(
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      print('Unknown error: $e');
    }
  }
}
