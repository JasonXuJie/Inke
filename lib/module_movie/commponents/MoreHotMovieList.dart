import 'package:flutter/material.dart';
import '../../bean/movie.dart';
import '../../config/AppConfig.dart';
import '../MovieDetails.dart';

class MoreHotMoviesList extends StatelessWidget {
  List<Subjects> data;

  MoreHotMoviesList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(context, data[index]);
        });
  }

  _buildItem(context, Subjects data) {
    var casts = List.generate(data.casts.length, (index){
      //Material(borderRadius: BorderRadius.all(100.0),),
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: FadeInImage.assetNetwork(
            placeholder: AppImgPath.mainPath+'app_icon.png',
            image: data.casts[index].avatars.medium,
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
        )
      );
    });
    return Card(
      margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetailsPage(id: data.id,)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 20.0),
              child:  FadeInImage.assetNetwork(
                placeholder: AppImgPath.mainPath + 'app_icon.png',
                image: data.images.medium,
                width: 100.0,
                height: 150.0,
                fadeInDuration: Duration(milliseconds: 1000),
                fadeOutDuration: Duration(milliseconds: 1000),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(data.title,style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child:  Text('评分:${data.rating.average}',style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14.0,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text('主演:'),
                        Wrap(
                          children: casts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
