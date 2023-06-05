import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

    final Function(int size, int nbMines) gotoGrid;

    const HomeScreen({
        super.key,
        required this.gotoGrid,
    });

    @override
    Widget build(BuildContext context) {
        return Center(
            child: Column(
                children: [
                    OutlinedButton(
                        onPressed: () => gotoGrid(7, 6),
                        child: const Text("Easy")
                    ),
                    OutlinedButton(
                        onPressed: () => gotoGrid(15, 45),
                        child: const Text("Medium")
                    ),
                    OutlinedButton(
                        onPressed: () => gotoGrid(35, 300),
                        child: const Text("Hard")
                    ),
                ]
            )
        );
    }

}
