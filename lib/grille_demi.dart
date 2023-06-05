import 'package:flutter/material.dart';
import 'package:demineur/modele.dart' as modele;

class GridScreen extends StatefulWidget {
  final modele.Grille grille;
  final Stopwatch timer;
  final void Function(Stopwatch, bool) gotoRes;

  const GridScreen({super.key, required this.grille, required this.timer, required this.gotoRes});
  @override
  State<StatefulWidget> createState() => _GrilleDemineur();
}

class _GrilleDemineur extends State<GridScreen> {

  @override
  Widget build(BuildContext context)
  {
    final modele.Grille _grille = widget.grille;
    final Stopwatch timer = widget.timer;
    int rowIM = 0;
    int colIM = 0;
    double size = 900/widget.grille.taille;
    bool isOver = _grille.isFinie();
    if(isOver){
        timer.stop();
    }
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("TP02/3 - Démineur")
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
                     dCase:dCase,
                     size: size); 
                  colIM++;
                  return cell;
                })
              ]);
              rowIM++;
              return colObj;
            }),
            Text(messageEtat(_grille)),
            Text(timer.elapsed.toString()),
            Builder(
              builder: (context) {
                if(isOver){
                    return OutlinedButton(
                      onPressed: () => widget.gotoRes(timer, _grille.isGagnee()),
                      child: const Text('Go to result screen')
                    );
                }
                else{
                    return OutlinedButton(
                      onPressed: () => {},
                      child: const Text('aaaaaaa')
                    );
                }
              }
            )
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

  void updateParent(modele.Grille grille, int x, int y, modele.Action action){
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
