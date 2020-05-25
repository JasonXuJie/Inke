import 'package:flutter/material.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:Inke/widgets/loading.dart';


class ComingSoonList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _State();
}


class _State extends State<ComingSoonList> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  MovieListEntity data;
  var _cityName;

  @override
  void initState() {
    super.initState();
    _cityName = Provider.of<CityProvider>(context,listen: false).name;
    Api.getCommingSoon(_cityName, (entity){
        if(mounted){
          setState(() {
            data = entity;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final changeCity = Provider.of<CityProvider>(context).name;
    if(_cityName != changeCity){
      _cityName = changeCity;
      setState(() {
        data = null;
      });
      Api.getCommingSoon(_cityName, (entity){
        if(mounted){
          setState(() {
            data = entity;
          });
        }
      });
    }
    return data == null ? LoadingView() : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.subjects.length,
      itemBuilder: (BuildContext context, int pos) {
        return _buildItem(context,data.subjects[pos]);
      },
    );
  }

  _buildItem(context, MovieListSubject itemData) {
    var genres = '';
    final heroTag = 'comming${itemData.title}';
    List.generate(itemData.genres.length, (index) {
      genres += itemData.genres[index] + '  ';
    });
//     var casts = List.generate(itemData.casts.length, (index) {
//       return itemData.casts[index].avatars ?? Padding(
//         padding: const EdgeInsets.only(left: 5.0),
//         child: loadFadeInNetImage(itemData.casts[index].avatars.small,
//             width: 50.0, height: 50.0, placeholder: 'app_icon'),
//       );
//     });
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: InkWell(
        onTap: () {
          NavigatorUtil.push(context, '${Routes.movieDetails}?id=${Uri.encodeComponent(itemData.id)}'
              '&title=${Uri.encodeComponent(itemData.title)}&image=${Uri.encodeComponent(itemData.images.medium)}');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
              child: loadFadeInNetImage(itemData.images.medium,
                  width: 100.0, height: 150.0, placeholder: 'app_icon'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(itemData.title, style: TextStyles.blackBold18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('类型:$genres', style: TextStyles.blackNormal14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('上映时间:${itemData.year}',
                        style: TextStyles.blackNormal14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '主演:',
                          style: TextStyles.blackNormal14,
                        ),
                        // Wrap(
                        //   children: casts,
                        // ),
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