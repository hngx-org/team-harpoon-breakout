import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:team_harpoon_breakout/screens/levels/level.dart';

class Breakout extends FlameGame {
  late final CameraComponent cam;
  @override
  final World world = Level();

  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 720,
      height: 1600,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    return super.onLoad();
  }
}
