import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:layered/core/router/app_router.dart';
import 'package:layered/core/services/hive_service.dart';
import 'package:layered/core/themes/light_theme.dart';
import 'package:layered/features/initial/presentation/cubit/splash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await HiveService.init();

  runApp(const LayeredApp());
}

class LayeredApp extends StatelessWidget {
  const LayeredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Layered',
        routerConfig: appRouter,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}