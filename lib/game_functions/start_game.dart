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
    updateDirection(ref);
    moveBall(ref);
    //Check if game is over
    if (isPlayerDead(ref)) {
      timer.cancel();
      ref.read(isGameOver.notifier).state = true;
    }
    checkBricksBroken(ref);
  });
}

void checkBricksBroken(WidgetRef ref) {
  var ballYState = ref.read(ballY.notifier).state;
  final ballXState = ref.read(ballX.notifier).state;
  // final brickXState = ref.read(firstbrickX.notifier).state;
  // final brickYState = ref.read(firstbrickY.notifier).state;
  final brickH = ref.read(brickHeight.notifier).state;
  final brickW = ref.read(brickWidth.notifier).state;
  final myBrick = ref.watch(myBricksProvider);
  for (int i = 0; i < myBrick.length; i++) {
    if (ballXState >= myBrick[i][0] &&
        ballXState <= myBrick[i][0] + brickW &&
        ballYState <= myBrick[i][1] + brickH &&
        myBrick[i][2] == false) {
      myBrick[i][2] = true;
      ref.read(ballYDirection.notifier).state = Direction.down;
    }
  }
}

bool isPlayerDead(WidgetRef ref) {
  final ballYState = ref.read(ballY.notifier).state;
  if (ballYState >= 1) {
    return true;
  }

  return false;
}

void updateDirection(WidgetRef ref) {
  var ballYState = ref.read(ballY.notifier).state;
  final ballXState = ref.read(ballX.notifier).state;
  final playerX = ref.read(playerPositionX.notifier).state;
  final playerWidthState = ref.read(playerWidth.notifier).state;

  //ball moves up when it hits the player
  if (ballYState >= 0.9 &&
      ballXState >= playerX &&
      ballXState <= playerX + playerWidthState) {
    ref.read(ballYDirection.notifier).state = Direction.up;
    //down when it hits the top of the screen
  } else if (ballYState <= -1) {
    ref.read(ballYDirection.notifier).state = Direction.down;
  }

  //ball moves left when it hits the wall
  if (ballXState >= 1) {
    ref.read(ballXDirection.notifier).state = Direction.left;
    //ball moves right when it hits the wall
  } else if (ballXState <= -1) {
    ref.read(ballXDirection.notifier).state = Direction.right;
  }
}

void moveBall(WidgetRef ref) {
  final ballDirectionY = ref.read(ballYDirection.notifier).state;
  final ballDirectionX = ref.read(ballXDirection.notifier).state;
  final incrementBrickX = ref.read(brickXIncrement.notifier).state;
  final incrementBrickY = ref.read(brickYIncrement.notifier).state;
  //move horinzontally
  if (ballDirectionX == Direction.left) {
    ref.read(ballX.notifier).state -= incrementBrickX;
  } else if (ballDirectionX == Direction.right) {
    ref.read(ballX.notifier).state += incrementBrickX;
  }

  //move vertically
  if (ballDirectionY == Direction.down) {
    ref.read(ballY.notifier).state += incrementBrickY;
  } else if (ballDirectionY == Direction.up) {
    ref.read(ballY.notifier).state -= incrementBrickY;
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
