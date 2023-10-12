import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class GameAudio extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    FlameAudio.bgm.play('full_moon.mp3');
  }
}
