import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../MovieDetails.dart';
import '../../config/AppConfig.dart';

class CommingSoonList extends StatelessWidget {
  List<Subjects> data;

  CommingSoonList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(context, data[index]);
        });
  }

  _buildItem(context, Subjects itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + '  ';
    });
    var casts = List.generate(itemData.casts.length, (index){
      return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: FadeInImage.assetNetwork(
            placeholder: AppImgPath.mainPath+'app_icon.png',
            image: itemData.casts[index].avatars.medium,
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          )
      );
    });
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                        id: itemData.id,
                      )));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
              child: FadeInImage.assetNetwork(
                placeholder: AppImgPath.mainPath + 'app_icon.png',
                image: itemData.images.medium,
                width: 100.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      itemData.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '类型:$genres',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '上映时间:${itemData.year}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text('主演:',style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),),
                        Wrap(
                          children: casts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
