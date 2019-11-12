import 'package:flutter/material.dart';
import 'package:Inke/bean/user.dart';

///ValueListenableBuilder的使用
class ValueListenable extends StatefulWidget {
  @override
  _ValueListenableState createState() => _ValueListenableState();
}

class _ValueListenableState extends State<ValueListenable> {

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('Good Job!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ValueListenableBuilder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            ValueListenableBuilder(
              builder: (context,int value,Widget child){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('$value'),
                    child
                  ],
                );
              },
              valueListenable: _counter,
              ///不需要监听值的控件我们放在别的地方初始化后，放入 child 参数中
              child: goodJob,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: ()=>_counter.value+=1),
    );
  }
}

///自定义ValueNotifier(更新对象其中一个字段)
class UserNotifier extends ValueNotifier<User>{

  UserNotifier(User usr):super(usr);


  void changeName(String name){
     value.name = name;
     notifyListeners();
  }


}
