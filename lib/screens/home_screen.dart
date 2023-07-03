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

    late Map players;

		@override
		void initState(){
			super.initState();
      ctrl = TextEditingController();
			ref.read(playerProvider.notifier).storage.ready.then((ready) {
				playerName = ref.read(playerProvider.notifier).getLastPlayer();
				ctrl.text = playerName;
			});
		}

    @override
    Widget build(BuildContext context) {

			Map players = ref.watch(playerProvider);
			Future storageFuture = ref.watch(playerProvider.notifier).storage.ready;
      diff = difficulty.Difficulty(chosenDiff);

      final List<difficulty.Level> options = [for (difficulty.Level level in difficulty.Level.values) level];

      return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(barText))
      ),
      body: FutureBuilder(
				future: storageFuture,
				builder: ((context, future) {
					if(future.hasError) {
						throw Error();
					} else if(!future.hasData) {
						return const Text("Loading page...");
					}
					return Center(
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
														playerName = ctrl.text;
													});
												},
											),
											const Spacer(),
											TextButton(
												child: const Text(
													"Play",
													style: TextStyle(fontSize: 20.0),
												),
												onPressed: () {
													//widget.changeName(ctrl.text),
													if(ctrl.text != "") {
														ref.read(playerProvider.notifier).loadPlayer(ctrl.text);
														ref.read(curPlayerProvider.notifier).state = ctrl.text;
														Navigator.of(context).push(
															MaterialPageRoute(builder: (context) => 
																GridScreen(gridSize: diff.taille, nbMines: diff.nbMines,)
															)
														);
													}
												},
											),
										]
									)
								),
								ScoreBoard()
							]
						)
					);
				})
			)
      );
    }
}

// Making it stateful and reusing "players" from homescreen prevented update after 2 player changes for some reason
class ScoreBoard extends ConsumerWidget {

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		Map players = ref.watch(playerProvider);
		return Column(
			children: [
				const Text(
					"Players:",
					style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
				),
				...players.entries.map((entry) => Text(
					"${entry.key}:    ${entry.value}",
					style: const TextStyle(fontSize: 20.0),
				)).toList()
			]
		);
	}
}
