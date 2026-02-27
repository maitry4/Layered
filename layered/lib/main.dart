import 'package:flutter/material.dart';
import 'package:layered/core/router/app_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
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