import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/bean/movie_detail_result_entity.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/util/screen_util.dart';
import 'package:Inke/config/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Inke/bean/still_result_entity.dart';
import 'package:Inke/bean/comment_result_entity.dart';
import 'package:Inke/config/route_config.dart';
import 'package:like_button/like_button.dart';
import 'dart:ui';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/shimmer_view.dart';
import 'package:Inke/widgets/text.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieListSubject data;

  MovieDetailsPage({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MovieDetailsPage> {
  MovieDetailResultEntity _detailData;
  double _ratingAverage = 0;
  bool _isOpenIntro = false;
  StillResultEntityEntity _stillData;
  CommentResultEntity _commentData;

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  _requestData() async {
    _detailData = await Api.getMovieDetails(widget.data.id);
    _stillData = await Api.getMovieStill(widget.data.id, 6);
    _commentData = await Api.getComments(widget.data.id);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(),
          _buildBody(),
          _buildComments(),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      title: Text(widget.data.title),
      expandedHeight: 300.0,
      pinned: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
            margin: EdgeInsets.only(
                top: ScreenUtil.getSafeTopPadding(context) + 56),
            child: Stack(
              ///高斯模糊效果
              children: <Widget>[
                loadNetImage(widget.data.images.medium,
                    width: ScreenUtil.getDeviceWidth(context),
                    height: 300,
                    fit: BoxFit.fill),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    width: ScreenUtil.getDeviceWidth(context),
                    height: 300,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        child: Hero(
                          tag: 'photo${widget.data.id}',
                          child: loadNetImage(widget.data.images.medium,
                              height: 200.0),
                        ),
                        onTap: () {
                          if (_detailData != null) {
                            RouteUtil.pushNamedByArgs(
                                context, RouteName.webName, {
                              'title': widget.data.title,
                              'url': _detailData.mobileUrl
                            });
                          }
                        },
                      )),
                )
              ],
            )),
      ),
    );
  }

  Widget _buildBody() {
    if (_commentData != null) {
      return SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            _buildInfo(),
            _buildMyRatingView(),
            Container(
              height: 5.0,
              color: AppColors.color_e6,
            ),
            _buildSummery(),
            _buildDirectorsAndCasts(),
            _buildStill(),
            Container(
              height: 5.0,
              color: AppColors.color_e6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                '评论区',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: ShimmerView(),
      );
    }
  }

  ///电影基本信息
  Padding _buildInfo() {
    var stringBuffer = StringBuffer();
    _detailData.casts
        .map((cast) => {stringBuffer.write('${cast.name} ')})
        .toList();
    double descWidth = ScreenUtil.getDeviceWidth(context) - 140;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _detailData.title,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.color_66,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _buildBasicText(
                  descWidth, '${_detailData.year}/${_detailData.genres}'),
              _buildBasicText(descWidth, '原名:${_detailData.originalTitle}'),
              _buildBasicText(descWidth, '导演:${_detailData.directors[0].name}'),
              _buildBasicText(descWidth, '主演:${stringBuffer.toString()}'),
            ],
          ),
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor,
                      offset: Offset(1, 1),
                      blurRadius: 3)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '综合评分',
                  style: TextStyle(fontSize: 12, color: AppColors.color_9d),
                ),
                Text(
                  _detailData.rating.average.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.color_66,
                      fontWeight: FontWeight.bold),
                ),
                _buildRatingView(_detailData.rating.average / 2, 12),
                Text(
                  '${_detailData.ratingsCount}人',
                  style: TextStyle(fontSize: 12, color: AppColors.color_9d),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///基本信息文字
  Container _buildBasicText(double width, String text) {
    return Container(
      width: width,
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: AppColors.color_9d),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  ///电影评分控件
  SmoothStarRating _buildRatingView(double rating, double size) {
    return SmoothStarRating(
      allowHalfRating: true,
      starCount: 5,
      rating: rating,
      size: size,
      color: AppColors.color_fc3,
      borderColor: AppColors.color_e6,
    );
  }

  ///我要评分控件
  Container _buildMyRatingView() {
    return Container(
      height: 48.0,
      margin: const EdgeInsets.only(
          top: 10.0, bottom: 20.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color_fc3, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '我来评分:',
            style: TextStyles.fc3Normal16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SmoothStarRating(
              allowHalfRating: true,
              starCount: 5,
              rating: _ratingAverage,
              size: 20,
              color: AppColors.color_fc3,
              borderColor: AppColors.color_e6,
              onRatingChanged: (rate) {
                setState(() {
                  _ratingAverage = rate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  ///简介
  Container _buildSummery() {
    return Container(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '剧情介绍',
              style: TextStyles.black15Bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    _detailData.summary,
                    style: TextStyle(
                        fontSize: 14.0, color: AppColors.color_9d, height: 1.2),
                    maxLines: _isOpenIntro ? 20 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Visibility(
                  visible: !_isOpenIntro,
                  child: Positioned(
                      right: 0,
                      bottom: 0,
                      width: 40,
                      height: 24,
                      child: FlatButton(
                          padding: const EdgeInsets.all(0),
                          color: AppColors.white,
                          onPressed: () {
                            setState(() {
                              _isOpenIntro = true;
                            });
                          },
                          child: Text(
                            "展开",
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.2,
                                color: Theme.of(context).primaryColor),
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///导演及演员
  Container _buildDirectorsAndCasts() {
    List data = [];
    for (int i = 0; i < _detailData.directors.length; i++) {
      data.add(_detailData.directors[i]);
    }
    for (int i = 0; i < _detailData.casts.length; i++) {
      data.add(_detailData.casts[i]);
    }
    var list = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int position) {
          return Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  loadNetImage(data[position].avatars.small,
                      width: 80.0, height: 100.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      data[position].name,
                      style: TextStyles.blackNormal14,
                    ),
                  ),
                ],
              ),
              onTap: () {
                RouteUtil.pushNamedByArgs(context, RouteName.webName,
                    {'title': data[position].name, 'url': data[position].alt});
              },
            ),
          );
        });
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '演职人员',
              style: TextStyles.black15Bold,
            ),
          ),
          Container(
            height: 150.0,
            child: list,
          )
        ],
      ),
    );
  }

  ///剧照
  Padding _buildStill() {
    List<Widget> widget = [];
    int photoCount = _stillData.photos[0].photosCount;
    for (StillResultEntityPhoto item in _stillData.photos) {
      widget.add(ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: loadNetImage(item.image,
              width: 220.0, height: 150.0, fit: BoxFit.fill),
        ),
      ));
    }
    widget.add(FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          RouteUtil.pushNamedByArgs(context, RouteName.stillName,
              {'id': _detailData.id, 'count': photoCount});
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            width: 150,
            height: 150,
            color: AppColors.color_9d,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '全部剧照',
                  style: TextStyles.ffNormal14,
                ),
                Container(
                  color: AppColors.color_ff,
                  width: 75,
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
                Text(
                  '$photoCount张',
                  style: TextStyles.ffNormal12,
                )
              ],
            ),
          ),
        )));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '剧照',
              style: TextStyles.black15Bold,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget,
            ),
          ),
        ],
      ),
    );
  }

  ///评论区
  Widget _buildComments() {
    if (_commentData != null) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            CommantResultCommants itemData = _commentData.comments[index];
            return Container(
              color: AppColors.color_ff,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipOval(
                    child: loadNetImage(itemData.author.avatar,
                        width: 36.0, height: 36.0),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  itemData.author.name,
                                  style: TextStyles.c6Nromal12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: _buildRatingView(
                                      itemData.rating.value / 2, 12),
                                ),
                              ],
                            ),
                            Expanded(
                              child: LikeButton(
                                size: 25.0,
                                likeCount: itemData.usefulCount,
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          itemData.content,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.color_66,
                              height: 1.1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              itemData.createdAt,
                              style: TextStyles.c6Nromal12,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            );
          },
          childCount: _commentData.comments.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  }
}
