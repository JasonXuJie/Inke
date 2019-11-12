import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/bean/still_result_entity.dart';
import 'package:photo_view/photo_view.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/widgets//loading.dart';

class PhotoPage extends StatefulWidget {
  final Map arguments;
  PhotoPage({this.arguments});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PhotoPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  StillResultEntityEntity _data;
  int _currPage = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _requestData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _requestData() async {
    _data = await Api.getMovieStill(widget.arguments['id'], widget.arguments['count']);
    setState(() {

    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '${this._currPage}/${widget.arguments['count']}',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: _buildBody()
    );
  }

  _buildBody() {
    if (_data != null) {
      return Transform.scale(
        scale: _animation.value,
        child: Container(
          child: PageView.builder(
              itemCount: _data.photos.length,
              onPageChanged: (int curPage) {
                setState(() {
                  _currPage = _currPage + 1;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return PhotoView(
                    backgroundDecoration:
                    BoxDecoration(color: AppColors.color_f5),
                    imageProvider: NetworkImage(_data.photos[index].image));
              }),
        ),
      );
    }else {
      return LoadingView();
    }
  }
}
