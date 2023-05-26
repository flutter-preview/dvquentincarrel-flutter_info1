import 'package:flutter/material.dart';
import 'package:demo/produit_manager.dart';

////////////////////////////////////////////////////////////////////////////////
// Exemple 4.3 : StateFul Widget ProduiManager
////////////////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Exemple 4.3 - Stateless MaterialApp avec Stateful ProduitManager"),
            ),
            body: Column(children: [ProduitManager('Machin')])));
  }
}

void main() {
  runApp(MyApp());
}
