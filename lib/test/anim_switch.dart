import 'package:flutter/material.dart';

class AnimPage extends StatefulWidget {
  @override
  _AnimPageState createState() => _AnimPageState();
}

class _AnimPageState extends State<AnimPage> {


  IconData _actionIcon = Icons.delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedSwitcherPage'),
        actions: <Widget>[
          AnimatedSwitcher(
              transitionBuilder: (child,anim){
                return ScaleTransition(scale: anim,child: child);
              },
              duration: Duration(milliseconds: 300),
              child: IconButton(
                  key: ValueKey(_actionIcon),
                  icon: Icon(_actionIcon),
                  onPressed: (){
                    setState(() {
                      if(_actionIcon == Icons.delete){
                        _actionIcon = Icons.done;
                      }else{
                        _actionIcon = Icons.delete;
                      }
                    });
                  }
              ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
