import 'package:flutter/material.dart';
import 'package:demo/modele.dart';

class MyApp extends StatefulWidget
{

    @override
    State<StatefulWidget> createState() {
        return _MyAppState();
    }

}

class _MyAppState extends State<MyApp>
{
    @override
    Widget build(BuildContext context)
    {
        return MaterialApp();
    }
}

void main() {
    runApp(MyApp());
}
