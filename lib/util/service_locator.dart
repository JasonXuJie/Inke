import 'package:get_it/get_it.dart';
import 'navigate_service.dart';

final GetIt getIt = GetIt();

void setupLocator() {
  getIt.registerSingleton(NavigateService());
}
