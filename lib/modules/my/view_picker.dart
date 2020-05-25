import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/config/colors.dart';

typedef void OnSelectItemCallBack(String item);

class PickerView extends StatefulWidget {

  final List<String> data;
  final OnSelectItemCallBack callBack;

  PickerView({Key key,@required this.data,@required this.callBack}):super(key:key);

  @override
  _State createState() => _State();
}


class _State extends State<PickerView> {

  FixedExtentScrollController _controller;
  var _itemIndex = 0;
  var content = '';

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: _itemIndex);
    content = widget.data[_itemIndex];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
     children: <Widget>[
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('取消',style: const TextStyle(
            fontSize: 14.0,
          ),)),
          FlatButton(onPressed: (){
            widget.callBack(content);
            Navigator.of(context).pop();
          }, child: Text('确定',style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.color_0099fd,
          ),),),
        ],
       ),
       SizedBox(
         height: 220.0,
         child: CupertinoPicker(
             scrollController: _controller,
             backgroundColor: CupertinoColors.white,
             itemExtent: 32.0,
             onSelectedItemChanged: (index){
               content = widget.data[index];
             },
             children:List<Widget>.generate(widget.data.length,(index){
                return Center(
                  child: Text(widget.data[index],style: const TextStyle(
                    fontSize: 22.0,
                    color: CupertinoColors.black,
                  ),),
                );
             })
         ),
       ),
     ],
    );
  }
}
