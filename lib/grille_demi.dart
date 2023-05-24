import 'package:flutter/material.dart';
import 'package:demineur/modele.dart' as modele;

class GrilleDemineur extends StatefulWidget {
  final int taille;
  final int nbMines;
  const GrilleDemineur(this.taille, this.nbMines);
  @override
  State<StatefulWidget> createState() => _GrilleDemineur();
}

class _GrilleDemineur extends State<GrilleDemineur> {
  late modele.Grille _grille;

  @override
  void initState() {
    _grille = modele.Grille(widget.taille, widget.nbMines);
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    int rowIM = 0;
    int colIM = 0;
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("TP02 - Démineur")
        ),
        body: Row(
          // Ligne -> Colonnes -> Cases
          children: [
            ..._grille.grille.map((row) {
              int rowI = rowIM;
              colIM = 0;
              var colObj = Column(children: [
                ...row.map((dCase) {
                  int colI = colIM;
                  var btn = OutlinedButton(
                    onPressed: () => setState(() { _grille.mettreAJour(modele.Coup(rowI, colI, modele.Action.decouvrir)); }),
                    onLongPress: () => setState(() { _grille.mettreAJour(modele.Coup(rowI, colI, modele.Action.marquer)); }),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(caseToColor(dCase)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    child: Text(caseToText(dCase, false)),
                  );
                  colIM++;
                  return btn;
                })
              ]);
              rowIM++;
              return colObj;
            })
          ]
        )
      )
    );
  }

  // "*" If undiscovered, "#nb" if there are any, nothing otherwise
  String caseToText(modele.Case laCase, bool isFini)
  {
    if(!laCase.decouverte){
      return "*";
    }

    if(laCase.minee) {
      return "💣";
    } else if(laCase.nbMinesAutour > 0) {
      return laCase.nbMinesAutour.toString();
    } else {
      return "";
    }
  }

  // Orange if marked, blue is undiscovered, grey otherwise
  Color caseToColor(modele.Case laCase)
  {
    if(laCase.marquee) {
      return Colors.orange;
    } else if(!laCase.decouverte) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  String messageEtat(modele.Grille grille)
  {
    return "";
  }
}
