import 'package:flutter/material.dart';
import 'package:demineur/home_page.dart';
import 'package:demineur/grille_demi.dart';
import 'package:demineur/results.dart';
import 'package:demineur/modele.dart' as modele;

class Demineur extends StatefulWidget {
    const Demineur({super.key});

    @override
    State<Demineur> createState() {
        return _DemineurState();
    }
}

enum ScreenState{home, grid, results}

class _DemineurState extends State<Demineur> {

    String pseudonym = "";
    late modele.Grille _grille;
    Stopwatch timer = Stopwatch();
    bool wasWon = false;

    ScreenState screenState = ScreenState.home;

    void changeName(String newName){
      pseudonym = newName;
    }

    void gotoGrid(int size, int nbMines) {
        setState(() {
            screenState = ScreenState.grid;
            _grille = modele.Grille(size,nbMines);
        });
    }

    void gotoResult(Stopwatch timer, bool wasWon) {
        setState(() {
            screenState = ScreenState.results;
            wasWon = wasWon;
        });
    }

    void gotoMain() {
        setState(() {
            screenState = ScreenState.home;
        });

    }

    Widget chooseScreenWidget() {
        switch(screenState) {
            case ScreenState.home: { return HomeScreen(
              gotoGrid: gotoGrid,
              currentName: pseudonym,
              changeName: changeName,
            ); }
            case ScreenState.grid: {
                timer.reset();
                timer.start();
                return GridScreen(grille: _grille, timer:timer, gotoRes: gotoResult);
            }
            case ScreenState.results: { 
              return ResultScreen(timer: timer, isWon: wasWon, gotoMain: gotoMain, playerName: pseudonym,); 
            }
        }
    }

    @override
    Widget build(context) {
        return MaterialApp(
            home:Scaffold(
                body: chooseScreenWidget()
            )
        );
    }
}

