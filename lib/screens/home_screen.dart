import 'package:demineur/screens/debug_screen.dart';
import 'package:demineur/screens/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:demineur/models/modele.dart' as modele;
import 'package:demineur/models/state.dart' as state;

// Make stateful

class HomeScreen extends StatefulWidget {
    //final Function(int size, int nbMines) gotoGrid;
    //final Function(String newName) changeName;
    //final Function() gotoDebug;
    final String currentName;
    final ctrl = TextEditingController();
    //state.GlobalState appState;

    HomeScreen({
      super.key,
      //required this.gotoGrid,
      //required this.changeName,
      required this.currentName,
      //required this.gotoDebug,
      //required this.appState,
    });

  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }

}

class _HomeScreen extends State<HomeScreen> {

    final List<List<dynamic>> options = [
      ["Easy", 7, 6],
      ["Medium", 15, 45],
      ["Hard", 35, 300],
    ];
    int chosenOpt = 0;
    late modele.Grille grille;
    

    @override
    Widget build(BuildContext context) {
      widget.ctrl.text = widget.currentName;
      final List<int> optionsRange = [for (int i = 0; i < options.length; i++) i];

      return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: widget.ctrl,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Pseudonym')),
            ),
            DropdownButton(
              value: chosenOpt,
              items: optionsRange.map(
                    (optInd) => DropdownMenuItem(
                      value: optInd,
                      child: Text(
                        options[optInd][0],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  chosenOpt = value;
                });
              },
            ),

            TextButton(
              onPressed: () => {
                //widget.changeName(widget.ctrl.text),
                if(widget.ctrl.text != ""){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => 
                      GridScreen(gridSize: options[chosenOpt][1], nbMines: options[chosenOpt][2],)
                    )
                  )
                }
              },
              child: const Text("Play")
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DebugScreen())
              ),
              child: const Text("Debug")
            ),
          ]
        )
      )
      );
    }

}
