import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class VictoryWidget extends StatefulWidget {
  final int levelNumber;
  final VoidCallback onMapTap;

  const VictoryWidget({
    super.key,
    required this.levelNumber,
    required this.onMapTap,
  });

  @override
  State<VictoryWidget> createState() => _VictoryWidgetState();
}

class _VictoryWidgetState extends State<VictoryWidget> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String _getRandomVictoryHeading(int level) {
    final headings = [
      "Pour-fect Sort!",
      "Sensational!",
      "Splendid Sort!",
      "Delicious!",
      "Superb Sorting!",
      "Sweet Victory!",
    ];
    return headings[level % headings.length];
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // Confetti
            Positioned.fill(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 35,
                gravity: 0.3,
              ),
            ),

            // Main Card
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 700),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.fromLTRB(20, 75, 20, 24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.18),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Level Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.primaryFixed ??
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        "LEVEL ${widget.levelNumber} COMPLETED",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Heading
                    Text(
                      _getRandomVictoryHeading(widget.levelNumber),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle text
                    Text(
                      "You sorted the layers flawlessly!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Animated Stars
                    const _ThreeStarsPop(),
                    const SizedBox(height: 28),

                    // Map Button (Secondary)
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.5),
                          width: 2,
                        ),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: IconButton(
                        onPressed: () {
                          _confettiController.stop();
                          widget.onMapTap();
                        },
                        icon: Icon(
                          Icons.map_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 26,
                        ),
                        tooltip: "Back to Map",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Orange Image (floating on top)
            Positioned(
              top: 0,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 850),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.elasticOut,
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/play/win_orange.webp',
                    height: 125,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreeStarsPop extends StatefulWidget {
  const _ThreeStarsPop();

  @override
  State<_ThreeStarsPop> createState() => _ThreeStarsPopState();
}

class _ThreeStarsPopState extends State<_ThreeStarsPop>
    with TickerProviderStateMixin {
  late final AnimationController _star1Ctrl;
  late final AnimationController _star2Ctrl;
  late final AnimationController _star3Ctrl;

  late final Animation<double> _star1Scale;
  late final Animation<double> _star2Scale;
  late final Animation<double> _star3Scale;

  @override
  void initState() {
    super.initState();

    _star1Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _star2Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _star3Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _star1Scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _star1Ctrl, curve: Curves.elasticOut));
    _star2Scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _star2Ctrl, curve: Curves.elasticOut));
    _star3Scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _star3Ctrl, curve: Curves.elasticOut));

    _playSequence();
  }

  Future<void> _playSequence() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) _star1Ctrl.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) _star2Ctrl.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) _star3Ctrl.forward();
  }

  @override
  void dispose() {
    _star1Ctrl.dispose();
    _star2Ctrl.dispose();
    _star3Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Star 1 (Left, slightly rotated and smaller)
        ScaleTransition(
          scale: _star1Scale,
          child: Transform.rotate(
            angle: -0.2,
            child: const _StarIcon(size: 40, isGolden: true),
          ),
        ),
        const SizedBox(width: 12),
        // Star 2 (Middle, bigger, straight)
        ScaleTransition(
          scale: _star2Scale,
          child: const _StarIcon(size: 56, isGolden: true, hasGlow: true),
        ),
        const SizedBox(width: 12),
        // Star 3 (Right, slightly rotated and smaller)
        ScaleTransition(
          scale: _star3Scale,
          child: Transform.rotate(
            angle: 0.2,
            child: const _StarIcon(size: 40, isGolden: true),
          ),
        ),
      ],
    );
  }
}

class _StarIcon extends StatelessWidget {
  final double size;
  final bool isGolden;
  final bool hasGlow;

  const _StarIcon({
    required this.size,
    required this.isGolden,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasGlow
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            )
          : null,
      child: Icon(
        Icons.star_rounded,
        size: size,
        color: isGolden ? Colors.amber[400] : Colors.grey[300],
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
