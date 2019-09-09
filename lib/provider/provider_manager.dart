import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/provider/first_provider.dart';
import 'package:Inke/provider/date_type_provider.dart';
import 'package:Inke/provider/login_provider.dart';


List<SingleChildCloneableWidget> providers = [
  Provider<CityProvider>.value(value: CityProvider()),
  Provider<FirstProvider>.value(value: FirstProvider()),
  Provider<LoginProvider>.value(value: LoginProvider()),
  Provider<DateTypeProvider>.value(value: DateTypeProvider(),)
];