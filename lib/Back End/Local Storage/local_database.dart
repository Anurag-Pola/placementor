import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../Front End/widgets/to_do_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _tododatabase; // Singleton Database
  static Database? _donedatabase;
  String todoTable = 'todo_table';
  String doneTable = 'done_table';
  String colDone = 'done';
  String colTodo = 'todo';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get tododatabase async {
    _tododatabase ??= await initializeToDoDatabase();
    return _tododatabase!;
  }

  Future<Database> get donedatabase async {
    _donedatabase ??= await initializeDoneDatabase();
    return _donedatabase!;
  }

  Future<Database> initializeToDoDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos.db';

    // Open/create the database at a given path
    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createToDoDb);
    return todosDatabase;
  }

  Future<Database> initializeDoneDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'dones.db';

    // Open/create the database at a given path
    var donesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDoneDb);
    return donesDatabase;
  }

  void _createToDoDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $todoTable($colTodo TEXT PRIMARY KEY)');
  }

  void _createDoneDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $doneTable($colDone TEXT PRIMARY KEY)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await tododatabase;
    var result = await db.query(todoTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getDoneMapList() async {
    Database db = await donedatabase;
    var result = await db.query(doneTable);
    return result;
  }

  // Insert Operation: Insert a todo object to database
  void insertTodo(Todo todo, BuildContext context) async {
    try {
      Database db = await tododatabase;
      await db.insert(todoTable, todo.toDoToMap());
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text('The To-Do is already present!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<int> insertDone(Todo todo) async {
    Database db = await donedatabase;
    var result = await db.insert(doneTable, todo.doneToMap());
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodo(String todo) async {
    var db = await tododatabase;
    int result =
        await db.delete(todoTable, where: 'todo = ?', whereArgs: [todo]);
    return result;
  }

  Future<int> deleteDone(String done) async {
    var db = await donedatabase;
    int result =
        await db.delete(doneTable, where: 'done = ?', whereArgs: [done]);
    return result;
  }

  // Get number of todo objects in database
  Future<int> getToDoCount() async {
    Database db = await tododatabase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  Future<int> getDoneCount() async {
    Database db = await donedatabase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $doneTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Todo> todoList = List<Todo>.empty(growable: true);
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.todofromMapObject(todoMapList[i]));
    }

    return todoList;
  }

  Future<List<Todo>> getDoneList() async {
    var doneMapList = await getDoneMapList(); // Get 'Map List' from database
    int count =
        doneMapList.length; // Count the number of map entries in db table

    List<Todo> doneList = List<Todo>.empty(growable: true);
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      doneList.add(Todo.donefromMapObject(doneMapList[i]));
    }

    return doneList;
  }
}
