import 'package:flutter/material.dart';
import 'package:demineur/models/modele.dart' as modele;

// Constructs every single cell of the grid
List makeGrid(modele.Grille grille,updateParent, screenSize) {
  List rows;

  int colIM = 0;
  int rowIM = 0;
  // Hacky and likely unflutter-like, but gets the job done
  double size = screenSize * 0.8 / grille.taille;

  // For each row, iter over its columns. For each column, generate a cell
  rows = grille.grille.map((row) {
    colIM = 0;
    var column = Column(children: [
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

// Handles all the logic, updating and display of a single cell
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
    final bool isFini = grille.isFinie();
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
          caseToText(dCase, isFini),
          style: TextStyle(fontSize: size/2.5),
          textAlign: TextAlign.center,
        )
      ),
      ),
    );

    return btn;
  }

  // Context-dependant text changes of the cell
  String caseToText(modele.Case laCase, bool isFini)
  {
    if(laCase.marquee){
      return "⚑";
    }
    if(!laCase.decouverte && !isFini){
      return "*";
    }
    if(laCase.minee) {
      // Only if the user clicked on a bomb
      return "💣";
    } else if(laCase.nbMinesAutour > 0) {
      // Number of bombs within the 8-neighbors, if any
      return laCase.nbMinesAutour.toString();
    } else {
      return "";
    }
  }

  // Context-dependant color changes of the cell
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
