import 'package:redux/redux.dart';
import 'package:Inke/bean/city.dart';

final CityReducer = combineReducers<City>([
  TypedReducer<City,UpdateCityAction>(_updateCity),
]);


City _updateCity(City city,action){
  city = action.city;
  return city;
}


class UpdateCityAction{
  final City city;
  UpdateCityAction(this.city);
}


