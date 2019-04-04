
class ApiService{
  //豆瓣
  static const DOUBAN_BASE_URL = 'https://api.douban.com/v2/';
  static const GET_CITYS = 'loc/list';
  static const GET_MOVIES = 'movie/in_theaters';
  static const GET_MOVIE_DETAILS = 'movie/subject/';
  static const GET_COMMING_SOON = 'movie/coming_soon';
  static const GET_TOP_250 = 'movie/top250';
  /**豆瓣同城
   * @param loc 城市id
   * @param dat_type  时间类型 future, week, weekend, today, tomorrow
   * @param 活动类型   all,music, film, drama, commonweal, salon, exhibition, party, sports, travel, others
   * */
  static const GET_EVENTS = 'event/list';
  static const GET_MUSICS = 'music/search';
  static const getMusic = 'https://api.douban.com/v2/music/search?q=周杰伦&start=0&count=20';


  //聚合数据
  static const JUHE_BASE_URL = 'http://v.juhe.cn';
  //历史上的今天
  static const TODAY_IN_HISTORY = '/todayOnhistory/queryEvent.php';
  static const HISTORY_DETAILS = '/todayOnhistory/queryDetail.php';
  static const HISTORY_KEY = '077b7c987d84e8fee312c23685528f59';
  //资讯
  static const NEWS = '/toutiao/index';
  static const NEWS_KEY = '790004a13a863058bf989cfdf470fda9';


  //阿凡达数据
  static const AFANDA_BASE_URL = 'http://api.avatardata.cn';
  //电影票房
  static const MOVIE_BOX_OFFICE = '/BoxOffice/Newest';
  static const MOVIE_BOX_OFFICE_NET='/BoxOffice/Internet';
  static const MOVIE_BOX_OFFICE_KEY = '49e139a435e44d728535119181f81352';
  //周公解梦
  static const  ZGJM ='/ZhouGongJieMeng/LookUp';
  static const ZGJM_KEY = '1fc2db7d3c9a46008046edc5085db958';
  //星座运势
  static const CONSTELLATION = '/Constellation/Query';
  static const CONSTELLATION_KEY = 'd91057d7e716450ba776ab8fa12a4b31';
  //星座配对
  static const PAIRING = '/XingZuoPeiDui/Lookup';
  static const PAIRING_KEY = '13bcbc09790046f9b5d621ac7b70fc91';
  //生肖配对
  static const CHINESE_PAIR ='/ShengXiaoPeiDui/Lookup';
  static const CHINESE_PAIR_KEY = '5734cd07cd7545b794a63dd7d8f49395';


}

