import 'package:flutter/material.dart';

import '../widgets/to_do_model.dart';
import '../../Back End/Local Storage/local_database.dart';
import 'package:sqflite/sqflite.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoListScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  List<Todo>? todoList = [];

  List<Todo>? doneList = [];

  String newToDo = "";
  bool expand = false;

  void updateListView() {
    final Future<Database> toDodbFuture =
        databaseHelper.initializeToDoDatabase();
    final Future<Database> donedbFuture =
        databaseHelper.initializeDoneDatabase();

    toDodbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          count = todoList.length + doneList!.length;
        });
      });
    });

    donedbFuture.then((database) {
      Future<List<Todo>> doneListFuture = databaseHelper.getDoneList();
      doneListFuture.then((doneList) {
        setState(() {
          this.doneList = doneList;
          count = doneList.length + todoList!.length;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("ToDo List", style: TextStyle(color: Colors.black)),
          backgroundColor: const Color(0xFFF7F9FC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                      "Add ToDo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  content: TextField(
                    onChanged: (String value) {
                      setState(() {
                        newToDo = value;
                      });
                    },
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        newToDo != ""
                            ? databaseHelper.insertTodo(Todo(newToDo), context)
                            : null;
                        updateListView();
                        newToDo = "";
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff925ffc),
                              Color(0xff3b57ff),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          "Add",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 60,
            height: 60,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff925ffc),
                  Color(0xff3b57ff),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i in todoList!)
                ListTile(
                  onTap: () {
                    databaseHelper.deleteTodo(i.todo);
                    databaseHelper.insertDone(Todo(i.todo));
                    updateListView();
                  },
                  title: Text(i.todo),
                  leading: const Icon(
                    Icons.circle_outlined,
                    color: Colors.blue,
                  ),
                ),
              for (var i in doneList!)
                ListTile(
                  onTap: () {
                    databaseHelper.deleteDone(i.todo);
                    databaseHelper.insertTodo(Todo(i.todo), context);
                    updateListView();
                  },
                  title: Text(
                    i.todo,
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  leading: const Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      databaseHelper.deleteDone(i.todo);
                      updateListView();
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
