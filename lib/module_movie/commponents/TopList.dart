import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';
import '../../config/AppConfig.dart';

class TopList extends StatelessWidget {
  List<Subjects> data;

  TopList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return _buildItem(context, data[index]);
        });
  }

  _buildItem(context, Subjects itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index){
      genres+=itemData.genres[index]+' ';
    });
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsPage(
                      id: itemData.id,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 0.0),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FadeInImage.assetNetwork(
                placeholder: AppImgPath.mainPath + 'app_icon.png',
                image: itemData.images.medium,
                width: 120.0,
                height: 80.0,
                fit: BoxFit.fill,
                fadeInDuration: Duration(milliseconds: 1000),
                fadeOutDuration: Duration(milliseconds: 1000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                itemData.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '类型:'+genres,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '上映时间:${itemData.year}',
                style: const TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '评分:${itemData.rating.average}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),

            ),
          ],
        ),
      ),
    );
  }
}
