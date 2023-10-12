// import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class GameAudio extends FlameGame with TapDetector {
  @override
  Color backgroundColor() =>
      Colors.transparent; // Set the background color to transparent
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    FlameAudio.bgm.play('full_moon.mp3');
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  // }

  /// Implement your game logic to detect when the game ends, and call this method
  static void gameEnd() {
    // Stop the background music
    FlameAudio.bgm.stop();

    // You can also perform other game end actions here
  }
}
