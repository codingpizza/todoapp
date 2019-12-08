import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/helper/DatabaseHelper.dart';
import 'package:sqlite/widgets/HomeScreen.dart';

import 'model/Todo.dart';

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