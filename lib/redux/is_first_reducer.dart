import 'package:redux/redux.dart';


final IsFirstReducer = combineReducers<bool>([
  TypedReducer<bool,UpdateIsFirstAction>(_updateIsFirst),
]);


bool _updateIsFirst(bool isFirst,action){
  isFirst = action.isFirst;
  return isFirst;
}


class UpdateIsFirstAction{
  final bool isFirst;
  UpdateIsFirstAction(this.isFirst);
}