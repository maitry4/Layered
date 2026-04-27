import 'package:flutter/material.dart';
class ActionButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final VoidCallback onTap;
  const ActionButton({super.key, this.label, this.child, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 130),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorScheme.secondaryContainer, colorScheme.secondary]),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: colorScheme.onPrimary, width: 4),
          boxShadow: [
            BoxShadow(color: colorScheme.shadow, blurRadius: 5, offset: const Offset(0, 3))
          ],
        ),
        child: Center(
          child: label != null
              ? Text(label!,
                  style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 20))
              : child,
        ),
      ),
    );
  }
}