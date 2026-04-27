import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const RoundButton({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.tertiary,
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.onPrimary, width: 3),
        ),
        child: Icon(icon, color: colorScheme.onTertiary, size: 28),
      ),
    );
  }
}

