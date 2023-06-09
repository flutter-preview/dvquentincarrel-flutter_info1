import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {

  //final Function gotoHome;
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          const Text('Page de debug'),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('Go home')
          )
        ]
      )
    );
  }
}
