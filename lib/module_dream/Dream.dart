import 'package:flutter/material.dart';
import 'dart:async';
import '../bean/dream_data.dart';
import '../util/DioUtil.dart';
import '../Api.dart';
import '../components/LoadingView.dart';
import 'DreamList.dart';

class DreamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DreamPage> {
  var _searchValue;

  Future<dreamData> _requestData() async {
    var response = await DioUtil.getAfdInstance().get(ApiService.ZGJM, data: {
      'key': ApiService.ZGJM_KEY,
      'keyword': _searchValue,
      'rows': 20,
      'page': 1
    });
    print(response);
    print(response is String);
    print(response is Map);
    return dreamData.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('周公解梦'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: '请输入内容，格式为梦见xxx',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 1.0,
                      ))),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                _searchValue = value;
              },
              onSubmitted: (String value) {
                setState(() {
                  _searchValue = value;
                });
              },
            ),
          ),
          _buildContainer()
        ],
      ),
    );
  }

  _buildContainer() {
    if (_searchValue != null) {
      return Expanded(
          child: FutureBuilder<dreamData>(
        future: _requestData(),
        builder: (BuildContext context, AsyncSnapshot<dreamData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return LoadingView();
              break;
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error.toString()}'),
                );
              } else {
                if (snapshot.data.result.length == 0) {
                  return Center(
                    child: Text('查询不到此信息'),
                  );
                } else {
                  return DreamList(
                    data: snapshot.data.result,
                  );
                }
              }
          }
        },
      ));
    } else {
      return Container();
    }
  }
}
