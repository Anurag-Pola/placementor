class Todo {
  late String _todo;

  Todo(this._todo);

  String get todo => _todo;

  set todo(String newTodo) {
    if (newTodo.length <= 255) {
      _todo = newTodo;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toDoToMap() {
    var map = <String, dynamic>{};

    map['todo'] = _todo;

    return map;
  }

  Map<String, dynamic> doneToMap() {
    var map = <String, dynamic>{};

    map['done'] = _todo;

    return map;
  }

  // Extract a Note object from a Map object
  Todo.todofromMapObject(Map<String, dynamic> map) {
    _todo = map['todo'];
  }

  Todo.donefromMapObject(Map<String, dynamic> map) {
    _todo = map['done'];
  }
}
