import 'package:demineur/screens/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:demineur/screens/home_screen.dart';
//import 'package:demineur/grille_demi.dart';
import 'package:demineur/screen.dart';

void main() {
  //runApp(const GrilleDemineur(10,10));
  runApp(const DemineurApp());
}

class DemineurApp extends StatelessWidget {
  const DemineurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(currentName: ""),
    );
  }

}
