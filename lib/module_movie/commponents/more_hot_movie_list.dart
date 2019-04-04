import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/module_movie//page_movie_details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';

class MoreHotMoviesList extends StatelessWidget {

  final List<MovieListSubject> data;

  MoreHotMoviesList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: data.length,
          itemBuilder: (BuildContext context,int index){
            return _buildItem(context, data[index],index);

          },
          staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 3 : 2.5),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
      );
  }

  _buildItem(context, MovieListSubject data,int index) {
    var isEven = index.isEven;
    var casts = List.generate(data.casts.length, (index){
      var cast = data.casts[index];
      if(cast.avatars!=null){
        return Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: FadeInImage.assetNetwork(
              placeholder: AppImgPath.mainPath+'app_icon.png',
              image: cast.avatars.medium,
              width: 40.0,
              height: 40.0,
              fit: BoxFit.fill,
            )
        );
      }
    });
    return Card(
      child: InkWell(
        onTap: () {
          RouteUtil.pushByWidget(context, MovieDetailsPage(id: data.id,));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: AppImgPath.mainPath + 'app_icon.png',
              image: data.images.medium,
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              fadeInDuration: Duration(milliseconds: 1000),
              fadeOutDuration: Duration(milliseconds: 1000),
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(top: isEven?10.0:0.0),
              child: Text(data.title,style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: isEven?5.0:0.0),
              child:  Text('评分:${data.rating.average}',style: const TextStyle(
                color: Colors.orange,
                fontSize: 14.0,
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: isEven?10.0:0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
