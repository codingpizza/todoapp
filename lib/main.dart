import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/DatabaseHelper.dart';

import 'Todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your favorite todo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a todo'),
      ),
      body: Column(
        children: <Widget>[
          Center(child: CreateTodoButton()),
          Center(child: ReadTodoButton())
        ],
      ),
    );
  }
}

class ReadTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Todos'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: DatabaseHelper().retrieveTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].content),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ReadTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateToReadTodoScreen(context);
      },
      child: Text("Read Todo"),
    );
  }

  _navigateToReadTodoScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadTodoScreen()),
    );
  }
}

class CreateTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateToCreateTodoScreen(context);
      },
      child: Text('Create a todo'),
    );
  }

  // A method that launches the SelectionScreen and awaits the
  // result from Navigator.pop.
  _navigateToCreateTodoScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => CreateTodoScreen()),
    );
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("You have selected $result")));
  }
}

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
    descriptionTextController.dispose();
    super.dispose();
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
            Navigator.pop(context, "Nota guardada con exito");
          }),
    );
  }
}