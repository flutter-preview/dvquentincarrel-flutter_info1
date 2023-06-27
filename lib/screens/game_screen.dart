import 'package:demineur/models/modele.dart' as modele;
import 'package:demineur/providers/app.dart';
import 'package:demineur/providers/game.dart';
import 'package:demineur/providers/player.dart';
import 'package:demineur/screens/results_screen.dart';
import 'package:demineur/widgets/sweeper.dart' as sweeper;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class GridScreen extends ConsumerStatefulWidget {
  late modele.Grille grille;
  // TODO: fetch those from the state
  final int gridSize;
  final int nbMines;

  GridScreen({super.key, required this.gridSize, required this.nbMines}){
    grille = modele.Grille(gridSize, nbMines);
  }

  @override
  ConsumerState<GridScreen> createState() => _GrilleDemineur();
}

class _GrilleDemineur extends ConsumerState<GridScreen> {

  @override
  void initState() {
    //final timer = ref.read(gameProvider)['timer'] as Stopwatch;
    final Stopwatch timer = Stopwatch();
    timer.start();
    final timer = ref.read(timerState);
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    final gameState = ref.read(gameProvider);
    final modele.Grille _grille = widget.grille;
    bool isOver = _grille.isFinie();
    final Stopwatch timer = gameState['timer'] as Stopwatch;
    int score = 0;

    if(isOver){
      timer.stop();
      if(_grille.isGagnee()){
        score = getScore(widget.gridSize, timer.elapsed);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(barText))
      ),
      backgroundColor: getBackgroundColor(isOver, _grille),
      body: Center(
        child: Column(
          children: [
            Row(
              // Ligne -> Colonnes -> Cases
              children: [
                const Spacer(),
                ...sweeper.makeGrid(_grille, updateParent),
                const Spacer()
              ]
            ),
            Text(
              messageEtat(_grille),
              style: const TextStyle(fontSize: 20.0)
            ),
            Text(
              timer.elapsed.toString(),
              style: const TextStyle(fontSize: 20.0),
              ),
            Builder(
              builder: (context) {
                return Visibility(
                  visible: isOver,
                  child: OutlinedButton(
                    onPressed: () => gotoRes(_grille.isGagnee(), score),//widget.gotoRes(timer, _grille.isGagnee()),
                    child: const Text(
                      'Go to result screen',
                      style: TextStyle(fontSize: 20.0)
                      )
                  ),
                );
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

  // Updates state before going to results page
  void gotoRes(bool wasWon, int score) {
    final String name = ref.read(playerProvider);

    ref.read(gameProvider.notifier).updateGame(wasWon: wasWon);
    ref.read(scoreProvider.notifier).updateScore(name, score);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(),
      )
    );
  }

  int getScore(int gridSize, Duration elapsedTime){
    int time = max(1, elapsedTime.inSeconds);
    return gridSize * gridSize ~/ time;
  }

  Color getBackgroundColor(bool isOver, modele.Grille grille){
    if(!isOver){
      return Colors.white;
    }
    if(grille.isGagnee()){
      return Colors.greenAccent[100]!;
    }
    return Colors.red[100]!;
  }

}

