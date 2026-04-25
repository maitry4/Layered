import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:layered/core/responsive/responsive_config.dart';
import 'package:layered/core/router/app_routes.dart';
import 'package:layered/features/game_play/domain/ui_level.dart';
import 'package:layered/features/game_play/presentation/cubit/game_play_cubit.dart';
import 'package:layered/features/game_play/presentation/widgets/action_button.dart';
import 'package:layered/features/game_play/presentation/widgets/bottle_widget.dart';
import 'package:layered/features/game_play/presentation/widgets/level_pill.dart';
import 'package:layered/features/game_play/presentation/widgets/round_button.dart';

class GamePlayBoard extends StatelessWidget {
  final UILevel level;
  final int? selectedIdx;
  const GamePlayBoard({required this.level, this.selectedIdx});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossAxisCount = isMobile ? 4 : 6;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TOP: HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundButton(
                    icon: Icons.arrow_back, onTap: () {
                      // Navigator.pop);
                      context.go(AppRoutes.gameMap); 
                    }),
                LevelPill(levelNumber: level.levelNumber),
                const SizedBox(width: 50), // Balance the row
              ],
            ),
          ),

          // MIDDLE: BOTTLES
          Expanded(
            child: Center(
              child: GridView.builder(
                shrinkWrap: true,
                // padding: const EdgeInsets.all(20),
                itemCount: level.tubes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: isMobile?240:350,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.5, 
                  // Matches the elegant bottle height
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => context.read<GamePlayCubit>().onTubeTapped(index),
                  child: BottleWidget(
                    tube: level.tubes[index],
                    isSelected: selectedIdx == index,
                  ),
                ),
              ),
            ),
          ),

          // BOTTOM: ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  child: const Icon(Icons.undo, color: Colors.white, size: 32),
                  onTap: () => context.read<GamePlayCubit>().undo(),
                ),
                const SizedBox(width: 30),
                ActionButton(
                  label: "RESET",
                  onTap: () => context.read<GamePlayCubit>().reset(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}