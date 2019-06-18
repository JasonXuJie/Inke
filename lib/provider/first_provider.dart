import 'package:flutter/material.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';


class FirstProvider with ChangeNotifier{

  bool _isFirst;

  FirstProvider(){
    _isFirst = SharedUtil.getInstance().get(SharedKey.isFirst, true);
  }


  void setFirst(bool isFirst){
    _isFirst = isFirst;
    SharedUtil.getInstance().put(SharedKey.isFirst, isFirst);
    notifyListeners();
  }


  bool get isFirst => _isFirst;


}