import 'package:flutter/material.dart';

class Counter extends ChangeNotifier{

  int _count = 100;

  get count => _count;

  increment(){
    _count++;
    notifyListeners();
  }

  addCount(){
    _count++;
    notifyListeners();
  }


}