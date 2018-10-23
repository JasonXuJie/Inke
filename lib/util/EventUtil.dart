import 'package:event_bus/event_bus.dart';

class EventUtil{

  static EventUtil _instance;
  EventBus eventBus;

  static EventUtil getInstance(){
    if(_instance == null){
      _instance = EventUtil();
    }
    return _instance;
  }

  EventUtil(){
    eventBus = EventBus();
  }

  post(event){
    eventBus.fire(event);
  }

  EventBus getEventBus() => eventBus;


}