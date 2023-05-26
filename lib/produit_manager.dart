import "package:flutter/material.dart";
import "package:demo/liste_produits.dart";

class ProduitManager extends StatefulWidget
{
  final String premierProduit;

  ProduitManager(this.premierProduit);

  @override
  State<StatefulWidget> createState()
  {
    return _ProduitManagerState();
  }
}

class _ProduitManagerState extends State<ProduitManager>
{
  List<String> _produits = [];

  @override
  void initState()
  {
    _produits.add(widget.premierProduit);
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(children: [
      Center(
        // margin: EdgeInsets.all(10.0),
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _produits.add("Bidule N° ${_produits.length}");
                  });
                },
                child: Text('Ajouter un élément'))),
      ),
      ListeProduits(_produits)
    ]);
  }
}
