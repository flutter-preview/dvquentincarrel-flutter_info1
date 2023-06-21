import 'package:flutter/material.dart';
import 'package:demineur/models/modele.dart' as modele;

// Constructs every single cell of the grid
List makeGrid(modele.Grille grille,updateParent) {
  List rows;

  int colIM = 0;
  int rowIM = 0;
  double size = 750/grille.taille;

  // For each row, iter over its elems
  rows = grille.grille.map((row) {
    colIM = 0;
    var column = Column(children: [
    // For each column in the row, generate a cell
    ...row.map((dCase) {
      return Cell(
           updateParent: updateParent,
           grille:grille,
           x:colIM++,
           y:rowIM,
           dCase:dCase,
           size: size); 
      })
    ]);
    rowIM++;
    return column;
  }).toList();

  return rows;
}

class Cell extends StatelessWidget {

  final void Function(modele.Grille, int, int, modele.Action) updateParent;
  final modele.Grille grille;
  final int x;
  final int y;
  final double size;
  final modele.Case dCase;

  const Cell({
    super.key,
    required this.updateParent,
    required this.grille,
    required this.x,
    required this.y,
    required this.dCase,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    var btn = SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
      onPressed: () => updateParent(grille, x, y, modele.Action.decouvrir),
      onLongPress: () => updateParent(grille, x, y, modele.Action.marquer),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(caseToColor(dCase)),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(EdgeInsets.zero), // and this
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          caseToText(dCase, false),
          style: TextStyle(fontSize: size/2.5),
          textAlign: TextAlign.center,
        )
      ),
      ),
    );

    return btn;
  }

  // "*" If undiscovered, "#nb" if there are any, nothing otherwise
  String caseToText(modele.Case laCase, bool isFini)
  {
    if(laCase.marquee){
      return "⚑";
    }
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
