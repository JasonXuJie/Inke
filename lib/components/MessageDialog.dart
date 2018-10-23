import 'package:flutter/material.dart';

class MessageDialog extends Dialog{

  String title;
  String message;
  String negativeText;
  String positiveText;
  Function onCloseEvent;
  Function onPositivePressEvent;


  MessageDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }):super(key:key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
              margin: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        Center(
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 19.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: this.onCloseEvent,
                          child: Padding(
                              padding:const EdgeInsets.all(5.0),
                              child: Icon(Icons.close,color: Color(0xffe0e0e0),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 180.0),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: IntrinsicHeight(
                          child: Text(
                            message,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                    ),
                  ),
                  _buildBtnGroup()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBtnGroup(){
    var widgets = <Widget>[];
    if(negativeText !=null && negativeText.isNotEmpty) widgets.add(_buildCancelBtn());
    if(positiveText !=null && positiveText.isNotEmpty) widgets.add(_buildSureBtn());
    return Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildCancelBtn(){
    return Flexible(
        fit: FlexFit.tight,
        child: FlatButton(
            onPressed: onCloseEvent,
            child: Text(
              negativeText,
              style: TextStyle(fontSize: 16.0),
            )
        )
    );
  }

  Widget _buildSureBtn(){
    return Flexible(
      fit: FlexFit.tight,
      child: FlatButton(
          onPressed: onPositivePressEvent,
          child: Text(
            positiveText,
            style: TextStyle(fontSize: 16.0),
          )
      ),
    );
  }


}