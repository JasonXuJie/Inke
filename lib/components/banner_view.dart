import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/image_util.dart';


class BannerView extends StatelessWidget {

  final List<MovieListSubject> dataList;
  var newIndex = 0;

  BannerView({Key key,this.dataList}):super(key: key);


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
          builder: SwiperPagination.dots,
        ),
        //control: SwiperControl(),
        onIndexChanged: (index) {
          newIndex = index;
        },
      ),
    );
  }

  _buildItem(BuildContext context,MovieListSubject itemData) {
    if (itemData is MovieListSubject) {
      return GestureDetector(
        onTap: () {
          RouteUtil.pushByWidget(context, MovieDetailsPage(data: itemData,));
        },
        child:loadNetworkImage(itemData.images.medium,fit: BoxFit.fill),
      );
    }
  }

}
