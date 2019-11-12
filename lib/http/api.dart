import 'package:Inke/bean/history_list_result_entity.dart';
import 'package:Inke/bean/history_detail_result_entity.dart';
import 'package:Inke/bean/dream_result_entity.dart';
import 'package:Inke/bean/pairing_result_entity.dart';
import 'package:Inke/bean/action_result_entity.dart';
import 'package:Inke/bean/news_result_entity.dart';
import 'package:Inke/bean/movie_list_result_entity.dart';
import 'package:Inke/bean/still_result_entity.dart';
import 'package:Inke/bean/comment_result_entity.dart';
import 'package:Inke/bean/movie_detail_result_entity.dart';
import 'package:Inke/bean/city_result_entity.dart';
import 'package:Inke/http/http_manager_jh.dart';
import 'package:Inke/http/http_manager_afd.dart';
import 'package:Inke/http/http_manager.dart';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
class Api {
  ///豆瓣Api
  static const doubanBaseUrl = 'https://douban.uieee.com/v2/';

  ///获取电影详情
  static const getMovieDetailsUrl = 'movie/subject/';

  ///获取城市列表
  static const getCityListUrl = 'loc/list';

  ///获取电影列表
  static const getMovies = 'movie/in_theaters';

  ///获取即将上线的电影
  static const getCommingSoonMovie = 'movie/coming_soon';

  ///获取前250的电影
  static const getTop250Url = 'movie/top250';

  ///电影详情信息
  static String movieDetailsUrl(String id) =>
      getMovieDetailsUrl + '$id';

  ///电影详情剧照
  static String moviePhotosUrl(String id, int count) =>
      getMovieDetailsUrl + '$id/photos?count=$count';

  ///获取电影评论圈
  static String movieCommentsUrl(String id, int start, int count) =>
      getMovieDetailsUrl + '$id/comments?start=$start&count=$count';

  ///豆瓣同城
  ///@param loc 城市id
  ///@param dat_type  时间类型 future, week, weekend, today, tomorrow
  ///@param 活动类型   all,music, film, drama, commonweal, salon, exhibition, party, sports, travel, others
  ///
  static const getActionListUrl = 'event/list';

  ///聚合数据Api
  static const juheBaseUrl = 'http://v.juhe.cn';

  //历史上的今天列表
  static const getTodayList = '/todayOnhistory/queryEvent.php';
  static const getHistoryDetails = '/todayOnhistory/queryDetail.php';
  static const historyKey = '077b7c987d84e8fee312c23685528f59';

  //资讯
  static const getNewsListUrl = '/toutiao/index';
  static const newsKey = '790004a13a863058bf989cfdf470fda9';

  ///阿凡达数据Api
  static const afandaBaseUrl = 'http://api.avatardata.cn';

  //周公解梦
  static const getDreamUrl = '/ZhouGongJieMeng/LookUp';
  static const dreamKey = '1fc2db7d3c9a46008046edc5085db958';

  //星座配对
  static const getPairing = '/XingZuoPeiDui/Lookup';
  static const pairingKey = '13bcbc09790046f9b5d621ac7b70fc91';

  //生肖配对
  static const getChinesePairing = '/ShengXiaoPeiDui/Lookup';
  static const chinesePairingKey = '5734cd07cd7545b794a63dd7d8f49395';

  ///请求历史今天列表
  static Future<HistoryListEntity> getHistoryList(String date) async {
    final response = await JhHttpManager.getInstance().get(
        getTodayList,
        params: {'key': historyKey, 'date': date});
    return HistoryListEntity.fromJson(response);
  }

  ///历史今天详情
  static Future<HistoryDetailResult> getHistoryDetail(String e_id) async {
    final response = await JhHttpManager.getInstance().get(
        getHistoryDetails,
        params: {'key': historyKey, 'e_id': e_id});
    return HistoryDetailResultEntity.fromJson(response).result[0];
  }

  ///周公解梦
  static Future<DreamResultEntity> getDream(String searchValue) async {
    final response = await AfdHttpManager.getInstance().get(getDreamUrl,
        params: {
          'key': dreamKey,
          'keyword': searchValue,
          'rows': 20,
          'page': 1
        });
    return DreamResultEntity.fromJson(response);
  }

  //星座匹配
  static Future<PairingResultEntity> getConstellactionPairing(
      String xingzuo1, String xingzuo2) async {
    final response = await AfdHttpManager.getInstance()
        .get(getPairing, params: {
      'key': pairingKey,
      'xingzuo1': xingzuo1,
      'xingzuo2': xingzuo2
    });
    return PairingResultEntity.fromJson(response);
  }

  ///生肖匹配
  static Future<PairingResultEntity> getChineseZodiac(
      String shengxiao1, String shengxiao2) async {
    final response = await AfdHttpManager.getInstance()
        .get(getChinesePairing, params: {
      'key': chinesePairingKey,
      'shengxiao1': shengxiao1,
      'shengxiao2': shengxiao2,
    });
    return PairingResultEntity.fromJson(response);
  }

  ///新闻列表
  static Future<NewsResultEntity> getNewsList(String type)async{
     dynamic response = await JhHttpManager.getInstance().get(
        getNewsListUrl,
        params: {'type': type, 'key': newsKey});
     return compute(ParsingUtil.parsingNews,response);
  }

  ///活动列表
  static Future<ActionResultEntity> getActionList(String cityId, String dateType, String type)async{
    final response = await HttpManager.getInstance().get(getActionListUrl,
        params: {'loc': cityId, 'day_type': dateType, 'type': type});
    return compute(ParsingUtil.parsingActions,response);
  }

  ///首页列表
  static Future<List<MovieListEntity>> getHomeList(String cityName)async{
    List<MovieListEntity> datas = [];
    final hotResponse = await HttpManager.getInstance().get(
        getMovies,
        params: {'city': cityName, 'start': '0', 'count': '15'});
    datas.add(await compute(ParsingUtil.parsingMovies,hotResponse));
    final moreResponse = await HttpManager.getInstance().get(
        getMovies,
        params: {'city': cityName, 'start': '16', 'count': '26'});
    datas.add(await compute(ParsingUtil.parsingMovies,moreResponse));
    return datas;
  }

  ///获取更多热门电影
  static Future<MovieListEntity> getMoreHotMovieList(String cityName) async {
    final response =
        await HttpManager.getInstance().get(getMovies, params: {
      'city': cityName,
      'start': '16',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  ///获取即将上映列表
  static Future<MovieListEntity> getCommingSoon(String cityName) async {
    final response = await HttpManager.getInstance()
        .get(getCommingSoonMovie, params: {
      'city': cityName,
      'start': '0',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  ///获取top250榜单
  static Future<MovieListEntity> getTop250(int start) async {
    final response =
        await HttpManager.getInstance().get(getTop250Url, params: {
      'start': '$start',
      'count': '20',
    });
    return MovieListEntity.fromJson(response);
  }

  ///获取电影详情
  static Future<MovieDetailResultEntity> getMovieDetails(String id) async {
    final detailResponse =
        await HttpManager.getInstance().get(movieDetailsUrl(id));
    return MovieDetailResultEntity.fromJson(detailResponse);
  }

  ///获取电影剧照
  static Future<StillResultEntityEntity> getMovieStill(
      String id, int count) async {
    final stillResponse = await HttpManager.getInstance()
        .get(moviePhotosUrl(id, count));
    return StillResultEntityEntity.fromJson(stillResponse);
  }

  ///获取电影评论区
  static Future<CommentResultEntity> getComments(String id) async {
    final commentResponse = await HttpManager.getInstance()
        .get(movieCommentsUrl(id, 0, 8));
    return CommentResultEntity.fromJson(commentResponse);
  }

  ///获取城市列表
  static Future<CityResultEntity> getCityList() async {
    final response =
        await HttpManager.getInstance().get(getCityListUrl);
    return CityResultEntity.fromJson(response);
  }
}


class ParsingUtil{



  static MovieListEntity parsingMovies(dynamic response){
    return MovieListEntity.fromJson(response);
  }

  static NewsResultEntity parsingNews(dynamic response){
    return NewsResultEntity.fromJson(response);
  }


  static ActionResultEntity parsingActions(dynamic response){
    return ActionResultEntity.fromJson(response);
  }

}
