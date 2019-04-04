import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:Inke/module_movie/page_movie_details.dart';
//import 'package:Inke/bean/movie.dart';
import 'package:Inke/util/route_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';


class BannerView extends StatelessWidget {

  final List<dynamic> dataList;
  List<dynamic> data = [];
  var newIndex = 0;

  BannerView({Key key,this.dataList}):super(key: key);

  _disposeData() {
    for (var i = 0; i < dataList.length; i++) {
      data.add(dataList[i]);
      if (i == 3) {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _disposeData();
    return SizedBox(
      height: 250.0,
      child: Swiper(
        itemCount: data.length,
        index: newIndex,
        autoplay: true,
        loop: true,
        itemBuilder: (context, index) => _buildItem(context,data[index]),
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.all(10.0),
          builder: SwiperPagination.dots,
        ),
        //control: SwiperControl(),
        onIndexChanged: (index) {
          newIndex = index;
        },
//        onTap:(int index){
//          print(index);
//        }
      ),
    );
  }

  _buildItem(context,itemData) {
    if (itemData is MovieListSubject) {
      return GestureDetector(
        onTap: () {
          RouteUtil.pushByWidget(context, MovieDetailsPage(id: itemData.id,));
        },
        child: CachedNetworkImage(
          imageUrl: itemData.images.medium,
          fit: BoxFit.fill,
          placeholder: (context,url)=>Image.asset(
            AppImgPath.mainPath + 'img_loading.jpeg', fit: BoxFit.fill,),
          errorWidget: (context,url,error)=>Image.asset(
            AppImgPath.mainPath + 'img_loading_error.png',fit: BoxFit.fill,),),
      );
    }
  }

}