import 'package:flutter_riverpod/flutter_riverpod.dart';

// Holds the player's name
final playerProvider = StateNotifierProvider<PlayerState, String>((ref) => PlayerState());

class PlayerState extends StateNotifier<String> {
    PlayerState() : super('');
    void setName(String text) => state = text;
    void debug() => print(state);
}
