import 'package:flutter/gestures.dart';

class Todo {
  final int id;
  final String content;
  final String title;
  String get tableName => "Todo";

  Todo({this.id, this.content, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'title': title};
  }
}
