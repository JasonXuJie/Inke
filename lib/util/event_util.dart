import 'package:event_bus/event_bus.dart';

class EventUtil {
  static EventUtil _instance;
  EventBus _eventBus;

  static EventUtil getInstance() {
    if (_instance == null) {
      _instance = EventUtil();
    }
    return _instance;
  }

  EventUtil() {
    _eventBus = EventBus();
  }

  void post(dynamic event) {
    _eventBus.fire(event);
  }

  EventBus getEventBus() => _eventBus;
}
