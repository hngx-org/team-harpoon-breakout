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
    // update direction
    updateDirection(ref);

    // move ball
    moveBall(ref);

    // check if player is dead
    if (isPlayerDead(ref)) {
      timer.cancel();
      ref.read(hasGameEnded.notifier).state = true;
    }

    // check if the brick is struck
    checkForStruckBrick(ref);
  });
}

void checkForStruckBrick(WidgetRef ref) {
  var ballYState = ref.read(ballY.notifier).state;
  var ballXState = ref.read(ballX.notifier).state;
  var brickXState = ref.read(brickX.notifier).state;
  var brickYState = ref.read(brickY.notifier).state;
  var brickWState = ref.read(brickWidth.notifier).state;
  var brickHState = ref.read(brickHeight.notifier).state;

  if (ballXState >= brickXState &&
      ballXState <= brickXState + brickWState &&
      ballYState <= brickYState + brickHState &&
      ref.read(isBrickBroken.notifier).state == false) {
    ref.read(isBrickBroken.notifier).state = true;
    ref.read(ballYDirection.notifier).state = Direction.down;
  }
}

bool isPlayerDead(WidgetRef ref) {
  var ballYState = ref.read(ballY.notifier).state;
  if (ballYState >= 1) {
    return true;
  } else {
    return false;
  }
}

void updateDirection(WidgetRef ref) {
  var ballYState = ref.read(ballY.notifier).state;
  var playerX = ref.read(playerPositionX.notifier).state;
  var ballXState = ref.read(ballX.notifier).state;
  var playerWidthState = ref.read(playerWidth.notifier).state;

  // ball goes up when it strikes player
  if (ballYState >= 0.9 &&
      ballXState >= playerX &&
      ballXState <= playerX + playerWidthState) {
    ref.read(ballYDirection.notifier).state = Direction.up;
  }
  // ball goes down when it strikes top of the screeen
  else if (ballYState <= -1) {
    ref.read(ballYDirection.notifier).state = Direction.down;
  }
  // ball goes left when it strikes left of the screeen
  else if (ballXState <= -1) {
    ref.read(ballXDirection.notifier).state = Direction.right;
  }
  // ball goes right when it strikes right of the screeen
  else if (ballXState >= 1) {
    ref.read(ballXDirection.notifier).state = Direction.left;
  }
}

void moveBall(WidgetRef ref) {
  // move H
  final ball = ref.read(ballYDirection.notifier).state;
  if (ref.read(ballXDirection.notifier).state == Direction.right) {
    ref.read(ballX.notifier).state += 0.01;
  } else {
    ref.read(ballX.notifier).state -= 0.01;
  }

  // move V
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
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
