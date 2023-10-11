import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';

// callback to start the game
void startGame(
  WidgetRef ref,
) {
  ref.read(hasGameInitiated.notifier).state = true;
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    // ref.read(ballY.notifier).state -= 0.0001;
    moveBall(ref);
    updateDirection(ref);
  });
}

void updateDirection(WidgetRef ref) {}

void moveBall(WidgetRef ref) {
  final ball = ref.read(ballDirection.notifier).state;
  if (ball == Direction.down) {
    ref.read(ballY.notifier).state += 0.01;
  } else {
    ref.read(ballY.notifier).state -= 0.01;
  }
}

// callback to move right
void moveRight(WidgetRef ref) {
  if (!(ref.read(playerPositionX.notifier).state + 0.2 >= 1)) {
    ref.read(playerPositionX.notifier).state += 0.2;
  }
}

// callback to move left
void moveLeft(WidgetRef ref) {
  if (!(ref.read(playerPositionX.notifier).state - 0.2 < -1)) {
    ref.read(playerPositionX.notifier).state -= 0.2;
  }
}

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key, required this.hasGameInitiated});

  final bool hasGameInitiated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return hasGameInitiated
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.1),
            child: const Text(
              'Tap to start',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}
