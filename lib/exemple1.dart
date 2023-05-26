import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////////////////////
// Exemple 1 : MINIMAL APP II
////////////////////////////////////////////////////////////////////////////////

void main() {
  runApp(
    MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text(
            'Hello World !',
            style: TextStyle(
                fontSize: 30, fontFamily: 'Futura', color: Colors.blue),
          ),
        ),
      ),
    ),
  );
}