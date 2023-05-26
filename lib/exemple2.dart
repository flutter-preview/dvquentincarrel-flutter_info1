import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////////////////////
// Exemple 2 : BLUE BOX
////////////////////////////////////////////////////////////////////////////////

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            children: [BlueBox(), BlueBox(), BlueBox()],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

/*

Center(
child: Row(
children: [BlueBox(), BlueBox(), BlueBox()],
),
),

Center(
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
crossAxisAlignment: CrossAxisAlignment.center,
children: [BlueBox(), BiggerBlueBox(), BlueBox()],
),
),

Center(
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
BlueBox(),
Flexible(
fit: FlexFit.tight,
flex: 1,
child: BlueBox(),
),
Flexible(
fit: FlexFit.tight,
flex: 3,
child: BlueBox(),
),
],
),
),

Center(
child: Row(
children: [
Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Grenoble_City.jpg/220px-Grenoble_City.jpg'),
],
),
),
 */
