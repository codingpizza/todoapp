import 'package:flutter/material.dart';
import 'package:sqlite/model/Todo.dart';

import '../helper/DatabaseHelper.dart';

class CreateTodoScreen extends StatefulWidget {
  static const routeName = '/createTodoScreen';

  @override
  State<StatefulWidget> createState() {
    return _CreateTodoState();
  }
}

class _CreateTodoState extends State<CreateTodoScreen> {
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

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
          child: Icon(Icons.check),
          onPressed: () {
            DatabaseHelper().insertTodo(Todo(
                title: titleTextController.text,
                content: descriptionTextController.text));
            Navigator.pop(context, "Your todo has been saved.");
          }),
    );
  }
}
