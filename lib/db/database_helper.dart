import 'package:sqflite/sqflite.dart';
import 'package:Inke/bean/user.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelper {
  var path;

  DbHelper() {
    _initDb();
  }

  _initDb() async {
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'inke.db');
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE USER ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, sex TEXT, headerPath TEXT)');
      print('创建user表成功');
      await db.execute(
          'CREATE TABLE CITY ( id INTEGER PRIMARY KEY AUTOINCREMENT, cityName TEXT, cityId TEXT)');
      print('创建city表成功');
      await db.close();
    });
    print('数据库创建成功');
  }

  //删除数据库
  deleteDb() async {
    await deleteDatabase(path);
  }

//  bool insert() async {
//    //Database db = await openDatabase(path);
//    //String sql = 'INSERT INTO USER() VALUES()';
//  }

  static bool update() {}

  Future<bool> delete(String name) async {
    Database db = await openDatabase(path);
    String sql = 'DELETE FROM USER WHERE name = $name';
    int count = await db.rawDelete(sql);
    await db.close();
    if (count == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> query(String name) async {
    Database db = await openDatabase(path);
    String sql = 'SELECT * FROM USER WHERE name = $name';
    List<Map> result = await db.rawQuery(sql);
    if (result.length == 0) {
      return null;
    } else {
      var user = User.empty();
      user.name = result[0]['name'];
      return user;
    }
  }
}
