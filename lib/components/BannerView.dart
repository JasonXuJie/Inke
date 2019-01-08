import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../module_movie/MovieDetails.dart';
import '../bean/movie.dart';
import '../util/JumpUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/AppConfig.dart';

class BannerView extends StatelessWidget {

  List<dynamic> dataList;
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
    if (itemData is Subjects) {
      return GestureDetector(
        onTap: () {
          JumpUtil.push(context, MovieDetailsPage(id: itemData.id,));
        },
        child: CachedNetworkImage(
          imageUrl: itemData.images.medium,
          fit: BoxFit.fill,
          placeholder: Image.asset(
            AppImgPath.mainPath + 'img_loading.jpeg', fit: BoxFit.fill,),
          errorWidget: Image.asset(
            AppImgPath.mainPath + 'img_loading_error.png',fit: BoxFit.fill,),),
      );
    }
  }

}
