import 'package:flutter/material.dart';
import 'package:sqlite/model/Todo.dart';
import 'package:sqlite/screens/CreateTodoScreen.dart';
import '../helper/DatabaseHelper.dart';

class ReadTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Todos'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: DatabaseHelper.databaseHelper.retrieveTodos(),
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
                      onPressed: () => _deleteTodo(snapshot.data[index])),
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

_deleteTodo(Todo todo) {
  DatabaseHelper.databaseHelper.deleteTodo(todo.id);
  //TODO: Pendiente de actualizar la vista
}

_navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailTodoScreen(todo: todo)),
  );
}
