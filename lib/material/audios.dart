import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

const sounds = [
  'clean.mp3',
  'drop.mp3',
  'explosion.mp3',
  'move.mp3',
  'rotate.mp3',
  'start.mp3',
];

const bgmTracks = [
  'bgm_classic.mp3',
  'bgm_action.mp3',
  'bgm_chill.mp3',
];

class Sound extends StatefulWidget {
  final Widget child;

  const Sound({super.key, required this.child});

  @override
  SoundState createState() => SoundState();

  static SoundState of(BuildContext context) {
    final state = context.findAncestorStateOfType<SoundState>();
    assert(state != null, 'can not find Sound widget');
    return state!;
  }
}

class SoundState extends State<Sound> {
  final _soundPlayers = <String, AudioPool>{};

  bool mute = false;

  int _bgmIndex = 0;
  bool _bgmActive = false;

  void _play(String name) {
    final player = _soundPlayers[name];
    if (player != null && !mute) {
      player.start();
    }
  }

  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.initialize();
    FlameAudio.updatePrefix('assets/audios/');
    for (final sound in sounds) {
      FlameAudio.createPool(sound, maxPlayers: 3).then((pool) {
        _soundPlayers[sound] = pool;
      });
    }
  }

  @override
  void dispose() {
    FlameAudio.bgm.dispose();
    FlameAudio.audioCache.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // ── Sound effects ────────────────────────────────────────────

  void start() {
    _play('start.mp3');
  }

  void clear() {
    _play('clean.mp3');
  }

  void fall() {
    _play('drop.mp3');
  }

  void rotate() {
    _play('rotate.mp3');
  }

  void move() {
    _play('move.mp3');
  }

  // ── Background music ─────────────────────────────────────────

  String get _currentTrack => bgmTracks[_bgmIndex % bgmTracks.length];

  /// Start (or resume) background music.
  void playBgm() {
    if (mute) return;
    if (_bgmActive) {
      FlameAudio.bgm.resume();
    } else {
      FlameAudio.bgm.play(_currentTrack, volume: 0.45);
      _bgmActive = true;
    }
  }

  /// Pause background music (game paused).
  void pauseBgm() {
    if (_bgmActive) {
      FlameAudio.bgm.pause();
    }
  }

  /// Advance to the next track and play it (called on new game / reset).
  void nextBgmTrack() {
    _bgmIndex = (_bgmIndex + 1) % bgmTracks.length;
    _bgmActive = false;
    FlameAudio.bgm.stop();
    if (!mute) {
      FlameAudio.bgm.play(_currentTrack, volume: 0.45);
      _bgmActive = true;
    }
  }

  /// Called when the mute toggle changes.
  void onMuteChanged() {
    if (mute) {
      FlameAudio.bgm.pause();
    } else if (_bgmActive) {
      FlameAudio.bgm.resume();
    }
  }
}
