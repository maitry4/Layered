import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:layered/core/responsive/responsive_config.dart';
import 'package:layered/core/router/app_routes.dart';
import 'package:layered/features/game_play/presentation/cubit/game_play_cubit.dart';
import 'package:layered/features/game_play/presentation/widgets/game_play_board.dart';
import 'package:layered/features/game_play/presentation/widgets/victory_widget.dart';

class GamePlayScreen extends StatelessWidget {
  final int levelNumber;

  const GamePlayScreen({super.key, required this.levelNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GamePlayCubit()..loadLevel(levelNumber),
      child: Scaffold(
        body: BlocListener<GamePlayCubit, GamePlayState>(
          listener: (context, state) {
            if (state is GamePlayVictory) {
              _showVictoryDialog(context, state.levelNumber);
            }
          },
          child: BlocBuilder<GamePlayCubit, GamePlayState>(
            builder: (context, state) {
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 2000),
                tween: Tween(begin: 1.1, end: 1.0),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        _backgroundAsset(context),
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    switch (state) {
                      GamePlayLoading() => Center(
                        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      GamePlayLoaded(:final level, :final selectedTubeIndex) =>
                        GamePlayBoard(
                          level: level,
                          selectedIdx: selectedTubeIndex,
                        ),
                      GamePlayVictory() => const SizedBox.shrink(),
                      GamePlayError(:final message) => Center(
                        child: Text(
                          message,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    },
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showVictoryDialog(BuildContext context, int currentLevel) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (dContext) {
        return VictoryWidget(
          levelNumber: currentLevel,
          onMapTap: () {
            context.go(AppRoutes.gameMap);
          },
          
        );
      },
    );
  }

  String _backgroundAsset(BuildContext context) {
    return Responsive.isMobile(context)
        ? 'assets/play/game_play_background_mobile.webp'
        : 'assets/play/game_play_background_desktop.webp';
  }
}
