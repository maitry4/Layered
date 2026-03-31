import 'package:flutter/material.dart';

class GamePlayScreen extends StatelessWidget {
  final int levelNumber;

  const GamePlayScreen({super.key, required this.levelNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Level $levelNumber")),
    );
  }
}