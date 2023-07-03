import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:math';

final playerProvider = StateNotifierProvider<playerState, Map>((ref) => playerState());
class playerState extends StateNotifier<Map> {
		late LocalStorage storage;

		playerState(): super({}) {
			storage = LocalStorage("flutter_data.json");
			storage.ready.then((ready) {
				if(ready) {
					state = storage.getItem("players");
				} else {
					throw Error();
				}
			});
		}

		// Attempts to load a player. Adds them if they don't exist
		int loadPlayer(String player){
			if(!state.containsKey(player)) {
				state[player] = 0;
				storage.setItem("players", state);
			} 
			int score = state[player]!;
			storage.setItem("lastPlayer", player);
			state = {...state};
			return score;
		}

		String getLastPlayer(){
			String lastplayer = storage.getItem("lastPlayer");
			return lastplayer;
		}

		void updateScore(String name, int score){
			state[name] = max(state[name] as int, score);
			storage.setItem("players", state);
			state = {...state};
		}
}

final storeProvider = Provider<LocalStorage>((ref) => LocalStorage("flutter_data.json"));

final curPlayerProvider = StateProvider<String>((ref) => ref.read(playerProvider.notifier).getLastPlayer());
