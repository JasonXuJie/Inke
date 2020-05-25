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
import 'package:Inke/http/http_client_jh.dart';
import 'package:flutter/foundation.dart';
import 'package:Inke/http/http_client.dart';
import 'package:Inke/http/http_client_afd.dart';

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
  static String movieDetailsUrl(String id) => getMovieDetailsUrl + '$id';

  ///电影详情剧照
  static String moviePhotosUrl(String id, int count) => getMovieDetailsUrl + '$id/photos?count=$count';

  ///获取电影评论圈
  static String movieCommentsUrl(String id, int start, int count) =>  getMovieDetailsUrl + '$id/comments?start=$start&count=$count';

  ///豆瓣同城
  ///@param loc 城市id
  ///@param dat_type  时间类型 future, week, weekend, today, tomorrow
  ///@param 活动类型   all,music, film, drama, commonweal, salon, exhibition, party, sports, travel, others
  ///
  static const getActionListUrl = 'event/list';


  ///聚合数据Api
  static const juheBaseUrl = 'http://v.juhe.cn';

  ///历史上的今天列表
  static const getTodayList = '/todayOnhistory/queryEvent.php';
  static const getHistoryDetails = '/todayOnhistory/queryDetail.php';
  static const historyKey = '077b7c987d84e8fee312c23685528f59';

  ///资讯
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

  ///获取电影首页数据
  static void getHomeData(String cityName,Function successCallBack,{Function failCallBack}){
      ///由于疫情现在数据很少，请求15条只返回7条数据
      HttpClient().get(
          url: getMovies,
          params:{'city': cityName, 'start': '0', 'count': '15'},
          tag:'home',
          successCallback: (jsonData){
            final entity = MovieListEntity.fromJson(jsonData);
            if(successCallBack != null){
              successCallBack(entity);
            }
          },
          failureCallback: (errInfo){

          }
      );
//      HttpClient().get(
//          url: getMovies,
//          params:{'city': cityName, 'start': '16', 'count': '26'},
//          tag:'home',
//          successCallback: (jsonData){
//
//          },
//          failureCallback: (errInfo){
//
//          }
//      );
  }

  ///获取新闻数据
  static void getNewsData(String type,Function successCallBack){
    HttpClientJh().get(
        url: getNewsListUrl,
        params: {'type': type, 'key': newsKey},
        tag: 'getNewsData',
        successCallback: (jsonData){
          final entity = NewsResultEntity.fromJson(jsonData);
          if(successCallBack !=null){
            successCallBack(entity);
          }
        }
    );
  }


  ///请求历史今天列表
  static void getHistoryListData(String date,Function successCallBack){
    HttpClientJh().get(
        url: getTodayList,
        params: {'key': historyKey, 'date': date},
        tag: 'getHistoryListData',
        successCallback: (jsonData){
          final entity = HistoryListEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///历史今天详情
  static void getHistoryDetail(String e_id,Function successCallBack){
     HttpClientJh().get(
         url: getHistoryDetails,
         params:{'key': historyKey, 'e_id': e_id},
         tag: 'getHistoryDetail',
         successCallback: (jsonData){
           final entity = HistoryDetailResultEntity.fromJson(jsonData).result[0];
           if(successCallBack != null){
             successCallBack(entity);
           }
         }
     );
  }

  ///周公解梦
  static void getDream(String searchValue,Function successCallback) async {
    HttpClientAfd().get(
        url: getDreamUrl,
        params: {
          'key': dreamKey,
          'keyword': searchValue,
          'rows': 20,
          'page': 1
        },
        tag: 'getDream',
        successCallback: (jsonData){
          final entity = DreamResultEntity.fromJson(jsonData);
          if(successCallback != null){
            successCallback(entity);
          }
        }
    );
  }

  ///星座匹配
  static void getConstellactionPairing(String xingzuo1, String xingzuo2,Function successCallBack){
    HttpClientAfd().get(
        url: getPairing,
        params: {
          'key': pairingKey,
          'xingzuo1': xingzuo1,
          'xingzuo2': xingzuo2
        },
        tag: 'getConstellactionPairing',
        successCallback: (jsonData){
          final entity = PairingResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///生肖匹配
  static void getChineseZodiac(String shengxiao1, String shengxiao2,Function successCallBack) {
    HttpClientAfd().get(
        url: getChinesePairing,
        params: {
          'key': chinesePairingKey,
          'shengxiao1': shengxiao1,
          'shengxiao2': shengxiao2,
        },
        tag: 'getChineseZodiac',
        successCallback: (jsonData){
          final entity = PairingResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///获取城市列表
  static void getCityList(Function successCallBack){
    HttpClient().get(
        url: getCityListUrl,
        tag: 'getCityList',
        successCallback: (jsonData){
          final entity = CityResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }



  ///活动列表
  static void getActionList(String cityId, String dateType, String type,Function successCallBack){
    HttpClient().get(
        url: getActionListUrl,
        params: {
          'loc': cityId,
          'day_type': dateType,
          'type': type
        },
        tag: 'getActionList',
        successCallback: (jsonData){
          final entity = ActionResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }




  ///获取即将上映列表
  static void getCommingSoon(String cityName,Function successCallBack) {
    HttpClient().get(
        url: getCommingSoonMovie,
        params: {
          'city': cityName,
          'start': '0',
          'count': '20',
        },
        tag: 'getCommingSoon',
        successCallback: (jsonData){
          final entity = MovieListEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///获取top250榜单
  static void getTop250(int start,Function successCallBack)  {
    HttpClient().get(
        url: getTop250Url,
        params: {
          'start': '$start',
          'count': '20',
        },
        tag: 'getTop250',
        successCallback: (jsonData){
          final entity = MovieListEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///获取电影详情
  static void getMovieDetails(String id,Function successCallBack){
    HttpClient().get(
        url: movieDetailsUrl(id),
        tag: 'getMovieDetails',
        successCallback: (jsonData){
          final entity = MovieDetailResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }

  ///获取电影剧照
  static void getMovieStill(String id, int count,Function successCallBack) {
    HttpClient().get(
        url: moviePhotosUrl(id, count),
        tag: 'getMovieStill',
        successCallback: (jsonData){
         final entity =  StillResultEntityEntity.fromJson(jsonData);
         if(successCallBack != null){
           successCallBack(entity);
         }
        }
    );
  }

  ///获取电影评论区
  static void getComments(String id,Function successCallBack)  {
    HttpClient().get(
        url: movieCommentsUrl(id, 0, 8),
        tag: 'getComments',
        successCallback: (jsonData){
          final entity = CommentResultEntity.fromJson(jsonData);
          if(successCallBack != null){
            successCallBack(entity);
          }
        }
    );
  }
}
