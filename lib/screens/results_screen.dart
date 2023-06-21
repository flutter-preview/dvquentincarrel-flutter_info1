import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur/providers/player.dart';
import 'package:demineur/providers/game.dart';
import 'package:demineur/providers/app.dart';

class ResultScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isWon = ref.read(gameProvider)['wasWon'] as bool;
    final String playerName = ref.read(playerProvider);
    final int score = ref.read(scoreProvider)[playerName] as int;
    final Stopwatch timer = ref.read(gameProvider)['timer'] as Stopwatch;
    final String time = getTime(timer);

    String message = isWon ? "You won!" : "You lost.";
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(barText))
      ),
      body: Center(
      child: Column(
        children: [
          Text('Player: $playerName'),
          Text(message),
          Text('Duration of your last game: $time'),
          Text('Best score: ${score.toString()}'),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Go to main menu'))
          ]
        )
      )
    );
  }

  String getTime(Stopwatch timer){
      String raw = timer.elapsed.toString();
      int dotIndex = raw.indexOf('.');
      String polished = raw.substring(0, dotIndex);
      return polished;
  }
}
