class ApiService {
  ///豆瓣Api
  static const doubanBaseUrl = 'https://douban.uieee.com/v2/';

  //获取城市列表
  static const getCityList = 'loc/list';

  //获取电影列表
  static const getMovies = 'movie/in_theaters';

  //获取电影详情
  static const getMovieDetails = 'movie/subject/';

  //获取即将上线的电影
  static const getCommingSoonMovie = 'movie/coming_soon';

  //获取前250的电影
  static const getTop250 = 'movie/top250';

  ///豆瓣同城
  ///@param loc 城市id
  ///@param dat_type  时间类型 future, week, weekend, today, tomorrow
  ///@param 活动类型   all,music, film, drama, commonweal, salon, exhibition, party, sports, travel, others
  ///
  static const GET_EVENTS = 'event/list';
  static const getMusics = 'music/search';
  static const getMusic =
      'https://api.douban.com/v2/music/search?q=周杰伦&start=0&count=20';

  ///聚合数据Api
  static const juheBaseUrl = 'http://v.juhe.cn';

  //历史上的今天列表
  static const getTodayList = '/todayOnhistory/queryEvent.php';
  static const getHistoryDetails = '/todayOnhistory/queryDetail.php';
  static const historyKey = '077b7c987d84e8fee312c23685528f59';

  //资讯
  static const getNewsList = '/toutiao/index';
  static const newsKey = '790004a13a863058bf989cfdf470fda9';

  ///阿凡达数据Api
  static const afandaBaseUrl = 'http://api.avatardata.cn';

  //周公解梦
  static const getDream = '/ZhouGongJieMeng/LookUp';
  static const dreamKey = '1fc2db7d3c9a46008046edc5085db958';

  //星座配对
  static const getPairing = '/XingZuoPeiDui/Lookup';
  static const pairingKey = '13bcbc09790046f9b5d621ac7b70fc91';

  //生肖配对
  static const getChinesePairing = '/ShengXiaoPeiDui/Lookup';
  static const chinesePairingKey = '5734cd07cd7545b794a63dd7d8f49395';
}
