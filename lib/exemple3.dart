import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////////////////////
// Exemple 3 : EXERCICE
////////////////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(title: Text('Welcome to Flutter')),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.account_circle, size: 50),
                  ),
                  Column(
                    children: [
                      Text('Flutter McFlutter',
                          style: Theme.of(context).textTheme.headline5),
                      Text('Experienced App Developer'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('123 Main Street'),
                  Text('415-555-0198'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.accessibility, size: 30),
                  Icon(Icons.timer, size: 30),
                  Icon(Icons.phone_android, size: 30),
                  Icon(Icons.phone_iphone, size: 30),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ],
          ),
        ));
  }
}

void main() {
  runApp(MyApp());
}
