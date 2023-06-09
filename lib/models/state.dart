import 'package:demineur/models/modele.dart' as modele;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Difficulty {Easy, Medium, Hard}
class AppState extends StateNotifier {
  AppState(): super([]);
  Difficulty difficulty = Difficulty.Easy;
  String pseudonym = "";
  late modele.Grille grille;
  Stopwatch timer = Stopwatch();

  void setName(String newName) { pseudonym = newName; }
  void setDifficulty(Difficulty newDiff) { difficulty = newDiff; }
}

