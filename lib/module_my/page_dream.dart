import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/bean/dream_result_entity.dart';
import 'package:Inke/http/http_manager_afd.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Inke/widgets/text.dart';

class DreamPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DreamPage> {
  var _searchValue;
  DreamResultEntity _data;
  var _isSubmit = false;

  _requestData() async {
    var response = await HttpManager.getInstance().get(ApiService.getDream,
        params: {
          'key': ApiService.dreamKey,
          'keyword': _searchValue,
          'rows': 20,
          'page': 1
        });
    //print(response);
    //print(response is String);
    //print(response is Map);
    setState(() {
      _data = DreamResultEntity.fromJson(response);
    });
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
                  hintStyle: TextStyles.greyNormal15,
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 1.0,
                      ))),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                _searchValue = value;
              },
              onSubmitted: (String value) {
                setState(() {
                  _isSubmit = true;
                });
                _requestData();
              },
            ),
          ),
          RaisedButton(
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              setState(() {
                _isSubmit = true;
              });
              _requestData();
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5)
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text('提交', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Expanded(
              child: Offstage(
            offstage: !_isSubmit,
            child: _data == null ? LoadingView() : _buildContent(),
          ))
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_data.result == null) {
      return Center(
        child: Text('参数不正确', style: TextStyle(fontSize: 15.0)),
      );
    } else {
      return DreamList(
        data: _data.result,
      );
    }
  }
}

class DreamList extends StatelessWidget {
  final List<DreamResult> data;

  DreamList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildItem(data[index]);
        });
  }

  _buildItem(DreamResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 15.0),
          child: Text(
            '标题:${data.title}',
            style: TextStyles.blackBold18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 25.0),
          child: Text(
            '类型:${data.type}',
            style: TextStyles.greyNormal13,
          ),
        ),
        Html(
          data: data.content,
          padding: const EdgeInsets.only(left: 25.0, top: 15.0),
          defaultTextStyle: TextStyles.greyNormal15,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Divider(),
        )
      ],
    );
  }
}
