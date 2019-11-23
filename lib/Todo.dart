import 'package:flutter/gestures.dart';

class Todo {
  final int id;
  final String content;
  final String title;
  static const String _TABLENAME = "todos";

  Todo({this.id, this.content, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'title': title};
  }

  static String tableName(){
    return _TABLENAME;
  }
}
