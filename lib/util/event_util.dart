import 'package:event_bus/event_bus.dart';

class EventUtil<E>{

  static EventUtil _instance;
  EventBus _eventBus;

  static EventUtil getInstance(){
    if(_instance == null){
      _instance = EventUtil();
    }
    return _instance;
  }

  EventUtil(){
    _eventBus = EventBus();
  }

  post(event){
    _eventBus.fire(event);
  }

  EventBus getEventBus() => _eventBus;


  test(OnEventCallBack callBack){
    _eventBus.on<E>().listen((event){
       callBack.callBack(event);
    });
  }



}

abstract class OnEventCallBack{

  void callBack(dynamic event);
}