import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final bool isWon;
  final Stopwatch timer;
  final void Function() gotoMain;

  const ResultScreen({super.key, required this.isWon, required this.timer, required this.gotoMain});
  @override
  State<StatefulWidget> createState() => _ResultScreen();
}

class _ResultScreen extends State<ResultScreen> {
  

  @override
  Widget build(BuildContext context)
  {
    String message = widget.isWon ? "You have won!" : "You lost.";
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("TP02/3 - Démineur")
        ),
        body: Center(
        child: Column(
          children: [
            Text(message),
            Text('Duration of your last game: ' + widget.timer.elapsed.toString()),
            OutlinedButton(onPressed: () => widget.gotoMain(), child: const Text('Go to main menu'))
            ]
          )
        )
      )
    );
  }
}

