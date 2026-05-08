import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;

  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _scaleController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _fadeController.forward();
    _scaleController.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget.nextScreen,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                _buildLogoSection(),
                const SizedBox(height: 40),
                _buildImageStrip(),
                const Spacer(),
                _buildTagline(),
                const SizedBox(height: 40),
                _buildLoader(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withValues(alpha: 0.45),
                blurRadius: 28,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/icon.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [kPrimaryLight, kPrimaryColor, kAccentColor],
          ).createShader(bounds),
          child: const Text(
            'TETRIS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              letterSpacing: 10,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Classic Block Puzzle',
          style: TextStyle(
            color: kTextMuted,
            fontSize: 14,
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildImageStrip() {
    final images = [
      _SplashImageCard(
        assetPath: 'assets/images.jpeg',
        label: 'Play',
        color: kPrimaryColor,
      ),
      _SplashImageCard(
        assetPath: 'assets/13029774.png',
        label: 'Compete',
        color: kAccentColor,
      ),
      _SplashImageCard(
        assetPath: 'assets/images2.jpeg',
        label: 'Enjoy',
        color: kPrimaryLight,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: e.key == 0 ? 0 : 6,
                    right: e.key == images.length - 1 ? 0 : 6,
                  ),
                  child: e.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTagline() {
    return const Text(
      'Stack. Clear. Repeat.',
      style: TextStyle(
        color: kTextSecondary,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildLoader() {
    return SizedBox(
      width: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: const LinearProgressIndicator(
          backgroundColor: Color(0xFF2A2A4A),
          valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
          minHeight: 3,
        ),
      ),
    );
  }
}

class _SplashImageCard extends StatelessWidget {
  final String assetPath;
  final String label;
  final Color color;

  const _SplashImageCard({
    required this.assetPath,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Image.asset(
              assetPath,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 110,
                color: color.withValues(alpha: 0.1),
                child: Icon(Icons.image_outlined, color: color, size: 36),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
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
