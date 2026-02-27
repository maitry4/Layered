import 'package:flutter/material.dart';
import 'package:layered/core/router/app_router.dart';

void main() {
  runApp(const LayeredApp());
}

class LayeredApp extends StatelessWidget {
  const LayeredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Layered',
      routerConfig: appRouter,
    );
  }
}