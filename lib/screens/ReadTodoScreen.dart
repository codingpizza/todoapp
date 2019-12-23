import 'package:flutter/material.dart';
import 'package:sqlite/model/Todo.dart';
import 'package:sqlite/screens/DetailTodoScreen.dart';
import '../helper/DatabaseHelper.dart';

class ReadTodoScreen extends StatefulWidget {
  @override
  _ReadTodoScreenState createState() => _ReadTodoScreenState();
}

class _ReadTodoScreenState extends State<ReadTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Todos'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: DatabaseHelper.instance.retrieveTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  leading: Text(snapshot.data[index].id.toString()),
                  subtitle: Text(snapshot.data[index].content),
                  onTap: () => _navigateToDetail(context, snapshot.data[index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _deleteTodo(snapshot.data[index]);
                        setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_deleteTodo(Todo todo) {
  DatabaseHelper.instance.deleteTodo(todo.id);
}

_navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailTodoScreen(todo: todo)),
  );
}
