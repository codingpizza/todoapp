import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Todo.dart';

class DatabaseHelper {
  Future<Database> database = initializeDatabase();
  static const databaseName = 'todos_database.db';

  static Future<Database> initializeDatabase() async {
    final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), databaseName), onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, content TEXT)");
    }, version: 1);
    return database;
  }

  Future<void> insertTodo(Todo todo) async {
    final Database db = await database;

    await db.insert(Todo.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> retrieveTodos() async {
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(Todo.TABLENAME);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }
}
