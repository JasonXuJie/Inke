import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:Inke/provider/date_provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_)=>CityProvider()),
  ChangeNotifierProvider(create: (_)=>LoginProvider()),
  ChangeNotifierProvider(create: (_)=>DateType())
];