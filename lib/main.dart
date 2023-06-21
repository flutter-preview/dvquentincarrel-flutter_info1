import 'package:demineur/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:demineur/screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  //runApp(const GrilleDemineur(10,10));
  runApp(const ProviderScope(child:DemineurApp()));
}

class DemineurApp extends StatelessWidget {
  const DemineurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}
