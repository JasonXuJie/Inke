import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';


class BannerView extends StatelessWidget {

  final List<MovieListSubject> dataList;

  var newIndex = 0;

  BannerView({Key key,this.dataList}):assert(dataList!=null);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: Swiper(
        itemCount: dataList.length,
        index: newIndex,
        autoplay: true,
        loop: true,
        itemBuilder: (context, index) => _buildItem(context,dataList[index]),
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.all(10.0),
          builder: DotSwiperPaginationBuilder(
              size: 8,
              activeSize: 12,
              color: Colors.white, //点点的颜色
              activeColor: Colors.blueAccent)
        ),
        onIndexChanged: (index) {
          newIndex = index;
        },
      ),
    );
  }

  _buildItem(BuildContext context,MovieListSubject itemData) {
    final heroTag = 'banner${itemData.title}';
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, '${Routes.movieDetails}'
            '?id=${Uri.encodeComponent(itemData.id)}'
            '&title=${Uri.encodeComponent(itemData.title)}'
            '&image=${Uri.encodeComponent(itemData.images.medium)}'
            '&heroTag=${Uri.encodeComponent(heroTag)}');
      },
      child:Hero(
          tag: heroTag,
          child: loadNetworkImage(itemData.images.medium,fit: BoxFit.fill),
      )
    );
  }

}
