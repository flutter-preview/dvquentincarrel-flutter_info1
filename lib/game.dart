import 'package:flutter/material.dart';
import 'package:demineur/modele.dart' as modele;
import 'package:demineur/widgets/sweeper.dart' as sweeper;

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
            ...sweeper.makeGrid(_grille, updateParent),
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
                      child: const Text('Keep on playing')
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
