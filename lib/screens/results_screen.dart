import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur/providers/player.dart';
import 'package:demineur/providers/game.dart';
import 'package:demineur/providers/app.dart';

class ResultScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isWon = ref.read(gameProvider)['wasWon'] as bool;
    final String playerName = ref.watch(curPlayerProvider);
    final int score = ref.watch(playerProvider)[playerName];
    final String time = timeToString(ref.read(durationProvider));

    String message = isWon ? "You won!" : "You lost.";
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(barText))
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Player: $playerName',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              'Duration of your last game: $time',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
            'Best score: ${score.toString()}',
              style: const TextStyle(fontSize: 20.0),
            ),
            OutlinedButton(
							// Causes the home page not to properly refresh, particularly visible with the score board
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/')),
              child: const Text(
                'Go to main menu',
                style: const TextStyle(fontSize: 20.0),
              )
            )
          ]
        )
      )
    );
  }

  String timeToString(Duration duration){
      String raw = duration.toString();
      int dotIndex = raw.indexOf('.');
      String polished = raw.substring(0, dotIndex);
      return polished;
  }
}
