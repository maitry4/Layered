import 'package:flutter/material.dart';
class LevelPill extends StatelessWidget {
  final int levelNumber;
  const LevelPill({super.key, required this.levelNumber});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "Level $levelNumber",
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: colorScheme.inverseSurface),
      ),
    );
  }
}