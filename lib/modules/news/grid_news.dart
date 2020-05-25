import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/news_result_entity.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:flustars/flustars.dart';
import 'package:Inke/widgets/loading.dart';


class NewsList extends StatefulWidget {

  final String value;

  NewsList({Key key, @required this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<NewsList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  List<NewsResultResultData> dataList;

  @override
  void initState() {
    super.initState();
    Api.getNewsData(widget.value, (data){
        if(mounted){
          setState(() {
            dataList = data.result.data;
          });
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(ObjectUtil.isEmptyList(dataList)){
      return LoadingView();
    }else{
      return RefreshIndicator(
          onRefresh: _onRefresh,
          child: GridView.builder(
              padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
              itemCount:dataList.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: ScreenUtil.getScreenW(context)/2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemBuilder: (BuildContext context,int pos){
                return _buildItem(context, dataList[pos]);
              }
          )
      );
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      dataList = null;
    });
    Api.getNewsData(widget.value, (data){
      if(mounted){
        setState(() {
          dataList = data.result.data;
        });
      }
    });
  }


  _buildItem(BuildContext context,NewsResultResultData itemData){
    return InkWell(
      onTap: (){
        NavigatorUtil.push(context, '${Routes.web}?title=${Uri.encodeComponent(itemData.title)}&url=${Uri.encodeComponent(itemData.url)}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            loadFadeInNetImage(itemData.thumbnailPicS,fit: BoxFit.fill,height: ScreenUtil.getScreenH(context)),
            Wrap(
              direction: Axis.vertical,
              spacing: 2,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(itemData.title,style: TextStyles.whiteNormal14),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '来源:${itemData.authorName}',
                    style: TextStyles.whiteNormal12
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 10),
                  child: Text(
                    itemData.date,
                    style: TextStyles.whiteNormal12
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}