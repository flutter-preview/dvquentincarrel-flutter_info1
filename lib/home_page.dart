import 'package:flutter/material.dart';

// Make stateful

class HomeScreen extends StatefulWidget {
    final Function(int size, int nbMines) gotoGrid;
    final Function(String newName) changeName;
    final String currentName;
    final ctrl = TextEditingController();

    HomeScreen({
      super.key,
      required this.gotoGrid,
      required this.changeName,
      required this.currentName,
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
    

    @override
    Widget build(BuildContext context) {
      widget.ctrl.text = widget.currentName;
      final List<int> optionsRange = [for (int i = 0; i < options.length; i++) i];

      return Center(
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
                widget.changeName(widget.ctrl.text),
                if(chosenOpt != -1 && widget.ctrl.text != ""){
                  widget.gotoGrid(options[chosenOpt][1], options[chosenOpt][2])
                }
              },
              child: const Text("Play")
            )
          ]
        )
      );
    }

}
