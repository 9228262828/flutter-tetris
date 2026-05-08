import 'package:flutter/material.dart';
import 'package:tetris/theme/app_theme.dart';
import 'package:video_player/video_player.dart';

/// Auto-playing, looping inline video player for asset files.
/// Shows a styled dark-themed control bar with play/pause and mute.
class AppVideoPlayer extends StatefulWidget {
  final String assetPath;

  const AppVideoPlayer({super.key, required this.assetPath});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..setLooping(true)
      ..setVolume(1.0)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _initialized = true);
          _controller.play();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _toggleMute() {
    setState(() {
      _controller.setVolume(_controller.value.volume == 0 ? 1.0 : 0.0);
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: _initialized ? _buildPlayer() : _buildLoader(),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      height: 200,
      color: kSurfaceColor,
      child: const Center(
        child: CircularProgressIndicator(
          color: kAccentColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return GestureDetector(
      onTap: () => setState(() => _showControls = !_showControls),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          _buildControlBar(),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    final isPlaying = _controller.value.isPlaying;
    final isMuted = _controller.value.volume == 0;
    final pos = _controller.value.position;
    final dur = _controller.value.duration;

    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.75),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: kPrimaryColor,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _formatDuration(pos),
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
            const SizedBox(width: 4),
            const Text('/', style: TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(width: 4),
            Text(
              _formatDuration(dur),
              style: const TextStyle(color: Colors.white54, fontSize: 11),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _toggleMute,
              child: Icon(
                isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                color: kTextMuted,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return VideoProgressIndicator(
      _controller,
      allowScrubbing: true,
      padding: EdgeInsets.zero,
      colors: const VideoProgressColors(
        playedColor: kAccentColor,
        bufferedColor: Color(0xFF2A2A4A),
        backgroundColor: Color(0xFF1A1A2E),
      ),
    );
  }
}
