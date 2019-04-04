import 'package:redux/redux.dart';

final ActionReducer = combineReducers<String>([
  TypedReducer<String,UpdateActionDateTypeAction>(_updateAction),
]);

String _updateAction(String dateType,action){
   dateType = action.dateType;
   return dateType;
}


class UpdateActionDateTypeAction{
  final String dateType;
  UpdateActionDateTypeAction(this.dateType);
}