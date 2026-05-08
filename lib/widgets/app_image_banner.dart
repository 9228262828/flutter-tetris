import 'package:flutter/material.dart';
import 'package:tetris/theme/app_theme.dart';

/// A horizontal banner showing the three app images used across
/// the Settings, Privacy Policy, and Terms screens.
class AppImageBanner extends StatelessWidget {
  const AppImageBanner({super.key});

  static const _items = [
    _BannerItem(
      assetPath: 'assets/images.jpeg',
      label: 'Play',
      color: kPrimaryColor,
    ),
    _BannerItem(
      assetPath: 'assets/13029774.png',
      label: 'Compete',
      color: kAccentColor,
    ),
    _BannerItem(
      assetPath: 'assets/images2.jpeg',
      label: 'Enjoy',
      color: kPrimaryLight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: _items
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: e.key == 0 ? 0 : 6,
                    right: e.key == _items.length - 1 ? 0 : 6,
                  ),
                  child: _BannerCard(item: e.value),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BannerItem {
  final String assetPath;
  final String label;
  final Color color;

  const _BannerItem({
    required this.assetPath,
    required this.label,
    required this.color,
  });
}

class _BannerCard extends StatelessWidget {
  final _BannerItem item;

  const _BannerCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.color.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              item.assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: item.color.withValues(alpha: 0.08),
                child: Icon(Icons.image_outlined,
                    color: item.color.withValues(alpha: 0.6), size: 28),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.65),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: item.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
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
