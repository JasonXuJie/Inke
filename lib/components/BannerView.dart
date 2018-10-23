import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../module_movie/MovieDetails.dart';
import '../bean/movie.dart';
class BannerView extends StatefulWidget{

  List<dynamic> dataList;

  BannerView({Key key,this.dataList}):super(key:key);

  @override
  State<StatefulWidget> createState() => _BannerState();

}


class _BannerState extends State<BannerView>{

  List<dynamic> data = [];
  var newIndex = 0;

  _disposeData(){
    for(var i=0;i<widget.dataList.length;i++){
      data.add(widget.dataList[i]);
      if(i == 3){
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _disposeData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Swiper(
        itemCount: data.length,
        index: newIndex,
        autoplay: true,
        loop: true,
        itemBuilder: (context,index)=>_buildItem(data[index]),
        pagination:SwiperPagination(),
        onIndexChanged: (index){
          newIndex = index;
        },
//        onTap:(int index){
//          print(index);
//        }
      ),
    );
  }
  
  
  _buildItem(itemData){
    if(itemData is Subjects){
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsPage(id:itemData.id ,)));
        },
        child: Image.network(itemData.images.medium,fit: BoxFit.fill,),
      );
    }
  }
  
}