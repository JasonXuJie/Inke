import 'package:redux/redux.dart';

final IsLoginReducer = combineReducers<bool>([
  TypedReducer<bool,UpdateIsLoginAction>(_updateIsLogin),
]);


bool _updateIsLogin(bool isLogin,action){
  isLogin = action.isLogin;
  return isLogin;
}


class UpdateIsLoginAction{
  final bool isLogin;
  UpdateIsLoginAction(this.isLogin);
}