import 'package:Inke/bean/user.dart';
import 'package:Inke/bean/city.dart';
import 'package:Inke/redux/user_reducer.dart';
import 'package:Inke/redux/city_reducer.dart';
import 'package:Inke/redux/is_first_reducer.dart';
import 'package:Inke/redux/is_login_reducer.dart';
import 'package:Inke/redux/action_date_type_reducer.dart';

///全局共享状态

class GlobalState {
  User user;
  City city;
  bool isLogin;
  bool isFirst;
  String dateType;

  GlobalState({this.user, this.city, this.isLogin, this.isFirst,this.dateType});
}

//reducer
GlobalState appReducer(GlobalState state, action) {
  return GlobalState(
    user: UserReducer(state.user, action),
    city: CityReducer(state.city, action),
    isLogin: IsLoginReducer(state.isLogin, action),
    isFirst: IsFirstReducer(state.isFirst, action),
    dateType: ActionReducer(state.dateType,action),
  );
}
