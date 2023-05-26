import 'package:flutter/material.dart';

class ListeProduits extends StatelessWidget {
  final List<String> produits;
  ListeProduits(this.produits);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: produits
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
            .toList());
  }
}
