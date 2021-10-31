import 'package:flutter/material.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoListScreen> {
  final List<String> _todoList = [
    "Complete HackerRank Stack Problems",
    "Apply for Company-X",
  ];

  final List<String> _doneList = [
    "Complete HackerRank Array Problems",
  ];

  String newToDo = "";
  bool expand = false;

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
                        setState(() {
                          newToDo != "" ? _todoList.add(newToDo) : null;
                        });
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
              for (var i in _todoList)
                ListTile(
                  onTap: () {
                    setState(() {
                      _todoList.remove(i);
                      _doneList.add(i);
                    });
                  },
                  title: Text(i),
                  leading: const Icon(
                    Icons.circle_outlined,
                    color: Colors.blue,
                  ),
                ),
              for (var i in _doneList)
                ListTile(
                  onTap: () {
                    setState(() {
                      _doneList.remove(i);
                      _todoList.add(i);
                    });
                  },
                  title: Text(
                    i,
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  leading: const Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _doneList.remove(i);
                      });
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
