import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Inke/test/counter.dart';

class ProviderPage extends StatefulWidget {
  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends State<ProviderPage> {


  @override
  void initState() {
    super.initState();
   int count =  Provider.of<Counter>(context, listen: false).count;
    print('initState:${count}');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Column(
          children: <Widget>[
            Container(
                child: Center(
                  child: Text('${Provider.of<Counter>(context).count}'),
                ),
//              child: Consumer<Counter>(
//                  builder: (BuildContext context,Counter provider,_){
//                    print("builder调用:${provider.count}");
//                    return Text('${provider.count}');
//                  },
//                  child: Text('child'),
//              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Provider.of<Counter>(context,listen: false).increment();
          }
      ),
    );
  }

}
