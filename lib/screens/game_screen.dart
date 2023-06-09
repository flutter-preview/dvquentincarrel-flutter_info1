import 'package:flutter/material.dart';
import 'package:demineur/models/modele.dart' as modele;
import 'package:demineur/screens/results_screen.dart';
import 'package:demineur/widgets/sweeper.dart' as sweeper;

class GridScreen extends StatefulWidget {
  late modele.Grille grille;
  Stopwatch timer = Stopwatch();
  final int gridSize;
  final int nbMines;

  GridScreen({super.key, required this.gridSize, required this.nbMines}){
    grille = modele.Grille(gridSize, nbMines);
    timer.reset();
    timer.start();
  }
  @override
  State<StatefulWidget> createState() => _GrilleDemineur();
}

class _GrilleDemineur extends State<GridScreen> {

  @override
  Widget build(BuildContext context)
  {
    final modele.Grille _grille = widget.grille;
    final Stopwatch timer = Stopwatch();
    bool isOver = _grille.isFinie();
    if(isOver){
        timer.stop();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("TP02/3 - Démineur")
      ),
      body: Row(
        // Ligne -> Colonnes -> Cases
        children: [
          ...sweeper.makeGrid(_grille, updateParent),
          Text(messageEtat(_grille)),
          Text(timer.elapsed.toString()),
          Builder(
            builder: (context) {
              if(isOver){
                  return OutlinedButton(
                    onPressed: () => {
                      //Navigator.of(context).pop(context),
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            isWon: _grille.isGagnee(),
                            timer: timer,
                            playerName: "Name lost in statelation"
                          ),
                        )
                      )
                    },//widget.gotoRes(timer, _grille.isGagnee()),
                    child: const Text('Go to result screen')
                  );
              }
              else{
                  return OutlinedButton(
                    onPressed: () => {},
                    child: const Text('Keep on playing')
                  );
              }
            }
          )
        ]
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
