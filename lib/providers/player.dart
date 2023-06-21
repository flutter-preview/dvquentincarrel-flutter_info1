import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

// Holds the player's name
// TODO: see if most minimal way to do this
final playerProvider = StateNotifierProvider<PlayerState, String>((ref) => PlayerState());

class PlayerState extends StateNotifier<String> {
    PlayerState() : super('');
    void setName(String text) => state = text;
    void debug() => print(state);
}

final scoreProvider = StateNotifierProvider<ScoreState, Map<String, int>>((ref) => ScoreState());

class ScoreState extends StateNotifier<Map<String, int>> {
    ScoreState(): super({});
    void updateScore(String name, int score){
        if(!state.containsKey(name)){
            state[name] = score;
        } else {
            state[name] = max(state[name]!, score);
        }
        state = {...state};
    }

}
