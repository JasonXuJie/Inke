import 'package:flutter/material.dart';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/widgets/text.dart';
class SearchBarDelegate extends SearchDelegate<String> {

  List<String> _data = ['搞笑', '爱情', '动作', '科技', '记录', '动漫', '犯罪', '战争'];

  ///清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black26,
        ),
        onPressed: (){
           query = "";
           showSuggestions(context);//搜索内容为空的时候显示建议搜索内容,也就是Widget buildSuggestions(BuildContext context)方法的的调用
        },
      )
    ];
  }

  ///返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.black26,
      ),
      onPressed: ()=>close(context,null),
    );
  }

  ///搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('搜索到的内容'),
    );
  }

  ///设置推荐
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
          children: <Widget>[
            Text('热搜关键字',style: TextStyles.blackBold18),

          ],
      ),
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
}
