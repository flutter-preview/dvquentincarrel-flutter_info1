import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////////////////////
// Exemple 4.2 : Stateless Widget, non décomposé
////////////////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  List<String> _produits = ['Bidule N° 0'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Exemple 4.1 - Stateless Widget MaterialApp"),
            ),
            body: Column(children: [
              Center(
                  // margin: EdgeInsets.all(10.0),
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _produits.add("Bidule N° ${_produits.length}");
                            print(_produits);
                          },
                          child: Text('Ajouter un élément')))),
              Column(
                  children: _produits
                      .map((unProduit) => Card(
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage('images/bidule.jpg'),
                                    height: 100),
                                Text(unProduit)
                              ],
                            ),
                          ))
                      .toList()),
            ])));
  }
}

void main() {
  runApp(MyApp());
}
