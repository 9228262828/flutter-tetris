import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameMaterial extends StatefulWidget {
  final Widget child;

  const GameMaterial({
    super.key,
    required this.child,
  });

  @override
  State<GameMaterial> createState() => _GameMaterialState();

  static ui.Image? getMaterial(BuildContext context) {
    final state = context.findAncestorStateOfType<_GameMaterialState>();
    return state?.material;
  }
}

class _GameMaterialState extends State<GameMaterial> {
  ///the image data of /assets/material.png
  ui.Image? material;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _doLoadMaterial();
  }

  void _doLoadMaterial() async {
    if (material != null) {
      return;
    }
    try {
      final bytes = await rootBundle.load("assets/material.png");
      final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          material = frame.image;
        });
      }
    } catch (e) {
      debugPrint("GameMaterial: failed to load material.png — $e");
      if (mounted) {
        setState(() {
          _loadFailed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show children once loaded, or if load failed (bricks don't need the sprite sheet)
    return (material != null || _loadFailed) ? widget.child : Container();
  }
}
