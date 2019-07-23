import 'package:flutter/material.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/components/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';

class CommingSoonList extends StatelessWidget {
  final List<MovieListSubject> data;

  CommingSoonList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(context, data[index]);
        });
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + '  ';
    });
    var casts = List.generate(itemData.casts.length, (index){
      return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child:loadFadeInNetImage(itemData.casts[index].avatars.medium,width: 50.0,height: 50.0,placeholder: 'app_icon'),
      );
    });
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: InkWell(
        onTap: () {
          RouteUtil.pushByWidget(context, MovieDetailsPage(data: itemData,));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
              child:loadFadeInNetImage(itemData.images.medium,width: 100.0,height: 150.0,placeholder: 'app_icon'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      itemData.title,
                      style: TextStyles.blackBold18
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '类型:$genres',
                      style: TextStyles.blackNormal14
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '上映时间:${itemData.year}',
                      style: TextStyles.blackNormal14
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text('主演:',style: TextStyles.blackNormal14,),
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
