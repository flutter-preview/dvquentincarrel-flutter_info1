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
              colIM = 0;
              var colObj = Column(children: [
                ...row.map((dCase) {
                  var cell =  Cell(
                     updateParent: updateParent,
                     grille:_grille,
                     x:colIM,
                     y:rowIM,
                     dCase:dCase); 
                  colIM++;
                  return cell;
                })
              ]);
              rowIM++;
              return colObj;
            }),
            Text(messageEtat(_grille))
          ]
        )
      )
    );
  }

  String messageEtat(modele.Grille grille)
  {
     if(grille.isGagnee()){
         return "You won";
     } else if(grille.isPerdue()) {
         return "You lost";
     } else {
         return "More to do";
     }
  }

  void updateParent(grille, x, y, action){
     setState(() => {
         grille.mettreAJour(modele.Coup(y, x, action)),
     });

  }
}

class Cell extends StatelessWidget {

    final void Function(modele.Grille, int, int, modele.Action) updateParent;
    final modele.Grille grille;
    final int x;
    final int y;
    final modele.Case dCase;

    const Cell({
        super.key,
        required this.updateParent,
        required this.grille,
        required this.x,
        required this.y,
        required this.dCase,
    });

  @override
  Widget build(BuildContext context) {
      var btn = SizedBox(
          width: 50,
          height: 50,
          child: OutlinedButton(
            onPressed: () => updateParent(grille, x, y, modele.Action.decouvrir),
            onLongPress: () => updateParent(grille, x, y, modele.Action.marquer),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(caseToColor(dCase)),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            child: Text(caseToText(dCase, false)),
          ),
      );

      return btn;
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
}
