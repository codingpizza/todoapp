import 'package:flutter/material.dart';
import 'package:sqlite/model/Todo.dart';
import '../helper/DatabaseHelper.dart';

class DetailTodoScreen extends StatefulWidget {
  static const routeName = '/detailTodoScreen';
  final Todo todo;

  const DetailTodoScreen({Key key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoState(todo);
}

class _CreateTodoState extends State<DetailTodoScreen> {
  Todo todo;
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

  _CreateTodoState(this.todo);

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      descriptionTextController.text = todo.content;
      titleTextController.text = todo.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
              maxLines: 1,
              controller: titleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              maxLines: 10,
              controller: descriptionTextController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check), onPressed: () => _saveTodo()),
    );
  }

  _saveTodo() {
    if (todo == null) {
      DatabaseHelper().insertTodo(Todo(
          title: titleTextController.text,
          content: descriptionTextController.text));
      Navigator.pop(context, "Your todo has been saved.");
    } else {
      Navigator.pop(context);
    }
  }
}
