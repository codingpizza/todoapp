import 'package:flutter/material.dart';

import 'ReadTodoScreen.dart';

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