import 'package:flutter/material.dart';
import '../components/TypeText.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blue,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'images/app_icon.png',
                  width: 80.0,
                  height: 80.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: TypeText(
                  text: 'Inke',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  delay: 100,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: TypeText(
                      delay: 1000,
                      text: 'a Flutter Demo from J@son',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
