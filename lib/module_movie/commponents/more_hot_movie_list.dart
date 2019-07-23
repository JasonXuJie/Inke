import 'package:flutter/material.dart';
import 'package:Inke/module_movie//page_movie_details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/components/text.dart';

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
            child:loadFadeInNetImage(cast.avatars.medium,width: 40.0,height: 40.0,placeholder: 'app_icon'),
        );
      }
    });
    return Card(
      child: InkWell(
        onTap: () {
          RouteUtil.pushByWidget(context, MovieDetailsPage(data: data,));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loadFadeInNetImage(data.images.medium,width: MediaQuery.of(context).size.width,height: 150.0,placeholder: 'app_icon',fadeIn: 1000,fadeOut: 1000),
            Padding(
              padding: EdgeInsets.only(top: isEven?10.0:0.0),
              child: Text(data.title,style: TextStyles.blackBold16),
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
