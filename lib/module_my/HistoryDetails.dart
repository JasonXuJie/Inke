import 'package:flutter/material.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../bean/historydetails.dart';
import '../components/LoadingView.dart';
import '../config/AppConfig.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class HistoryDetailsPage extends StatefulWidget {
  String e_id;
  String title;

  HistoryDetailsPage({Key key, @required this.e_id, @required this.title})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HistoryDetailsPage> with TickerProviderStateMixin {
  TabController _controller;
  bool _isShow = false;
  Result data;

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  void _requestData() async {
    var response = await DioUtil.getJhInstance().get(ApiService.HISTORY_DETAILS,
        data: {'key': ApiService.HISTORY_KEY, 'e_id': widget.e_id});
    setState(() {
      data = historydetails.fromJson(response).result[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderLoading(),
    );
  }

  Widget _renderLoading() {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: LoadingView(),
      );
    } else {
      return Scaffold(body: _renderContent());
    }
  }

  _buildImages(Result data) {
    List<Widget> images = [];
    data.picUrl.forEach((picurl) {
      var image = GestureDetector(
        child: FadeInImage.assetNetwork(
          placeholder: AppImgPath.mainPath + 'app_icon.png',
          image: picurl.url,
          width: MediaQuery.of(context).size.width,
          height: 300.0,
          fit: BoxFit.fill,
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 300),
        ),
        onTap: () {
          setState(() {
            _isShow = true;
          });
        },
      );
      images.add(image);
    });
    return images;
  }

  Widget _renderContent() {
    if (!_isShow) {
      _controller = TabController(length: data.picUrl.length, vsync: this);
      var isVisible = false;
      if (data.picUrl.length <= 1) {
        isVisible = true;
      }
      return Offstage(
        offstage: _isShow,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(widget.title),
              centerTitle: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300.0,
                child: Stack(
                  children: <Widget>[
                    TabBarView(
                      controller: _controller,
                      children: _buildImages(data),
                    ),
                    Offstage(
                      offstage: isVisible,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TabPageSelector(
                            controller: _controller,
                            color: Colors.white,
                            selectedColor: Colors.blue,
                            indicatorSize: 13.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
              child: Text(
                data.content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),
              ),
            ))
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            _isShow = false;
          });
        },
        child: Container(
            color: Colors.black,
            child: PhotoViewGallery(
              pageOptions: getGallery(),
              // backgroundDecoration: BoxDecoration(color: Colors.black87),
            )),
      );
    }
  }

  List<PhotoViewGalleryPageOptions> getGallery() {
    return List<PhotoViewGalleryPageOptions>.generate(data.picUrl.length,
        (int index) {
      return PhotoViewGalleryPageOptions(
        imageProvider: NetworkImage(data.picUrl[index].url),
        heroTag: '$index',
        initialScale: PhotoViewComputedScale.contained * 0.98,
        minScale: PhotoViewComputedScale.contained * 0.3,
      );
    });
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }
}