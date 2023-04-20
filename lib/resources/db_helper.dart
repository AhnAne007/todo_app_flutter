import 'dart:async';
import 'dart:html';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'package:to_do_app/model/todo.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  //Write a function to initialize the table existence
  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentDirectory.path}ToDo.db';
    var db = await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return db;
  }

  //Write a function to create a table
  _onCreateDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE mytasktable("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " title TEXT NOT NULL,"
        " description TEXT NOT NULL,"
        " dateAndTime TEXT NOT NULL)");
  }

  //Write a function to insert in table
  Future<Todo> insert(Todo toDo) async {
    var dbClient = await db;
    await dbClient?.insert('mytasktable', toDo.toMap());
    return toDo;
  }

  //Write a function to get all the data from the table
  Future<List<Todo>> getListOfTodos() async {
    var dbClient = await db;
    final List<Map<String, Object?>> rawQueryResult = await dbClient!.rawQuery(
      "SELECT * FROM mytasktable",
    );
    return rawQueryResult.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return dbClient!.delete('mytasktable', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Todo toDo) async {
    var dbClient = await db;
    return dbClient!.update('mytasktable', toDo.toMap(),
        where: 'id = ?', whereArgs: [toDo.id]);
  }
}
