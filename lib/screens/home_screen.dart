import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:demineur/models/modele.dart' as modele;
import 'package:demineur/models/difficulty.dart' as difficulty;
import 'package:demineur/providers/player.dart';
import 'package:demineur/providers/app.dart';
import 'package:demineur/screens/game_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends ConsumerState<HomeScreen> {

    difficulty.Level chosenDiff = difficulty.Level.easy;
    late modele.Grille grille;
    late TextEditingController ctrl;
    late String playerName;
    late difficulty.Difficulty diff;

    @override
    Widget build(BuildContext context) {

      playerName = ref.watch(playerProvider);
      diff = difficulty.Difficulty(chosenDiff);

      ctrl = TextEditingController();
      ctrl.text = playerName;
      ctrl.selection = TextSelection.fromPosition(TextPosition(offset: playerName.length));
      ctrl.addListener(() {
        ref.watch(playerProvider.notifier).setName(ctrl.text);
      });

      final List<difficulty.Level> options = [for (difficulty.Level level in difficulty.Level.values) level];

      return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(barText))
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                controller: ctrl,
                maxLength: 50,
                style: const TextStyle(fontSize: 20.0),
                decoration: const InputDecoration(label: Text('Pseudonym')),
              )
            ),
            SizedBox(
              width: 500,
              child: Row(
                children: [
                  DropdownButton(
                    value: chosenDiff,
                    items: options.map(
                          (difficulty) => DropdownMenuItem(
                            value: difficulty,
                            child: Text(
                              difficulty.name,
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        chosenDiff = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text(
                      "Play",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () => {
                      //widget.changeName(ctrl.text),
                      if(ctrl.text != ""){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => 
                            GridScreen(gridSize: diff.taille, nbMines: diff.nbMines,)
                          )
                        )
                      }
                    },
                  ),
                ]
              )
            )
          ]
        )
      )
      );
    }
}
