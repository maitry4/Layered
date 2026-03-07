import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:layered/core/responsive/responsive_config.dart';
import 'package:layered/core/router/app_routes.dart';
import 'package:layered/features/initial/presentation/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

// ---------------------------------------------------------------------------
// View
// ---------------------------------------------------------------------------

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingPageChanged) {
          _pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
        if (state is OnboardingComplete) {
          context.goNamed(AppRoutes.gameMap);
        }
      },
      builder: (context, state) {
        final currentPage =
            state is OnboardingPageChanged ? state.currentPage : 0;

        return Scaffold(
          body: Stack(
            children: [
              // ── Full-screen paged images ──────────────────────────────────
              PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: kTotalOnboardingPages,
                itemBuilder: (_, index) => _OnboardingPage(index: index),
              ),

              // ── Bottom overlay: dots + button ─────────────────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomControls(currentPage: currentPage),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Full-screen image page
// ---------------------------------------------------------------------------

class _OnboardingPage extends StatelessWidget {
  final int index;

  const _OnboardingPage({required this.index});

  String _assetPath(BuildContext context) {
    final suffix = Responsive.isMobile(context) ? '' : 'd';
    return 'assets/ob${index + 1}$suffix.webp';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isLargeScreen = screenWidth >= AppBreakpoints.desktop;

    return Responsive(
      maxWidth: isLargeScreen ? AppBreakpoints.desktop : double.infinity,
      child: SizedBox.expand(
        child: Image.asset(
          _assetPath(context),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                size: 48,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom controls: dot indicators + action button
// ---------------------------------------------------------------------------

class _BottomControls extends StatelessWidget {
  final int currentPage;

  const _BottomControls({required this.currentPage});

  bool get _isLastPage => currentPage == kTotalOnboardingPages - 1;

  @override
  Widget build(BuildContext context) {
    final label = _isLastPage ? 'Get Started' : 'Next';

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DotIndicators(currentPage: currentPage),
          const SizedBox(height: 28),
          _GlossyButton(
            label: label,
            onPressed: () => context.read<OnboardingCubit>().next(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dot indicators
// ---------------------------------------------------------------------------

class _DotIndicators extends StatelessWidget {
  final int currentPage;

  const _DotIndicators({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(kTotalOnboardingPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.25),
          ),
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// Glossy game-style button — used for all onboarding CTAs
// ---------------------------------------------------------------------------

class _GlossyButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _GlossyButton({required this.label, required this.onPressed});

  @override
  State<_GlossyButton> createState() => _GlossyButtonState();
}

class _GlossyButtonState extends State<_GlossyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final base  = Theme.of(context).colorScheme.primary; // green700
    final light = const Color(0xFF3DBE74);               // green500
    final dark  = const Color(0xFF1A5C38);               // green800

    return GestureDetector(
      onTapDown:   (_) => setState(() => _pressed = true),
      onTapUp:     (_) { setState(() => _pressed = false); widget.onPressed(); },
      onTapCancel: ()  => setState(() => _pressed = false),
      child: AnimatedScale(
        scale:    _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 80),
        curve:    Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: dark, width: 2.5),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end:   Alignment.bottomCenter,
              colors: [light, base],
            ),
            boxShadow: [
              BoxShadow(
                color:      dark.withOpacity(0.6),
                blurRadius: 8,
                offset:     const Offset(0, 4),
              ),
              BoxShadow(
                color:        light.withOpacity(0.4),
                blurRadius:   4,
                spreadRadius: 1,
                offset:       Offset.zero,
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize:      22,
              fontWeight:    FontWeight.w900,
              color:         Colors.white,
              letterSpacing: 0.5,
              shadows: [
                Shadow(color: Color(0xFF0D3320), offset: Offset(0, 2), blurRadius: 4),
                Shadow(color: Color(0xFF0D3320), offset: Offset(0, 1), blurRadius: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}