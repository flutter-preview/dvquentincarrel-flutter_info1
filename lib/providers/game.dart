import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameProvider = StateNotifierProvider<GameState, Map<String, Object>>((ref) => GameState());

class GameState extends StateNotifier<Map<String, Object>>{

  GameState() : super({
    'difficulty': 0,
    'score': 0,
    'wasWon': false,
    'timer': Stopwatch(),
  });

  // Only updates provided values
  void updateGame({int? difficulty, int? score, bool? wasWon}){
    state['difficulty'] = difficulty ?? state['difficulty']!;
    state['score'] = score ?? state['score']!;
    state['wasWon'] = wasWon ?? state['wasWon']!;
    state = {...state};
  }
  void debug() => print(state);
}

//// TODO: fix
//final timeProvider = Provider<Stopwatch>(
//  (ref) => {
//    final timer = Stopwatch();
//    return timer; 
//  }
//  )
