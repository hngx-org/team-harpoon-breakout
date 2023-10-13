import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/audio/game_audio.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';

// callback to start the game
void startGame(
  WidgetRef ref,
) async {
  ref.read(hasGameInitiated.notifier).state = true;

  print(ref.watch(gameResume));
  if (ref.watch(gameResume)) {
    ref.read(gameResume.notifier).state = false;
    init(ref);
  } else {
    init(ref);
  }
}

void init(
  WidgetRef ref,
) {
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    // ref.read(ballY.notifier).state -= 0.0001;
    updateDirection(ref);
    moveBall(ref);

    //check if level completed
    if (ref.watch(levelCompleted)) {
      timer.cancel();
      ref.read(isGameOver.notifier).state = true;
      GameAudio.gameEnd();
      resetGame(ref);
    }

    ///Check if game is over
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
  final brickH = ref.read(brickHeight.notifier).state;
  final brickW = ref.read(brickWidth.notifier).state;
  final myBrick = ref.watch(myBricksProvider);
  for (int i = 0; i < myBrick.length; i++) {
    if (ballXState >= myBrick[i][0] &&
        ballXState <= myBrick[i][0] + brickW &&
        ballYState <= myBrick[i][1] + brickH &&
        myBrick[i][2] == false) {
      myBrick[i][2] = true;
      //check if all bricks is true
      ref.read(levelCompleted.notifier).state =
          myBrick.every((innerList) => innerList[2] == true);

      //since brick is broken, update direction of ball
      //based on which side the brick it hit
      //to achieve this, we calculate the distance of the ball from each of the four sides
      //the smallest distance is the side the ball has it

      ref.read(leftsideDist.notifier).state =
          ((myBrick[i][0] as double) - (ballXState)).abs();
      ref.read(rightsideDist.notifier).state =
          (((myBrick[i][0] + brickW) as double) - ballXState).abs();
      ref.read(topsideDist.notifier).state =
          ((myBrick[i][1] as double) - ballYState).abs();
      ref.read(bottomsideDist.notifier).state =
          ((myBrick[i][1] as double) + brickH - ballYState).abs();
      String min = findMin(
        ref.read(leftsideDist.notifier).state,
        ref.read(rightsideDist.notifier).state,
        ref.read(topsideDist.notifier).state,
        ref.read(bottomsideDist.notifier).state,
      );

      switch (min) {
        case "left":
          ref.read(ballXDirection.notifier).state = Direction.left;
          break;
        case "right":
          ref.read(ballXDirection.notifier).state = Direction.right;
          break;
        case "up":
          ref.read(ballYDirection.notifier).state = Direction.up;
          break;
        case "down":
          ref.read(ballYDirection.notifier).state = Direction.down;
          break;
        default:
      }
    }
  }
}

//returns the smallest side
String findMin(double a, double b, double c, double d) {
  List<double> myList = [
    a,
    b,
    c,
    d,
  ];
  double currentMin = 0;
  for (int i = 0; i < myList.length; i++) {
    if (myList[i] < currentMin) {
      currentMin = myList[i];
    }
  }
  if ((currentMin - a).abs() < 0.01) {
    return "left";
  } else if ((currentMin - b).abs() < 0.01) {
    return "right";
  } else if ((currentMin - c).abs() < 0.01) {
    return "up";
  } else if ((currentMin - d).abs() < 0.01) {
    return "down";
  }
  return "";
}

//reset game
void resetGame(WidgetRef ref) {
  ref.read(playerPositionX.notifier).state = -0.2;
  ref.read(ballX.notifier).state = 0;
  ref.read(ballY.notifier).state = 0;
  ref.read(isGameOver.notifier).state = false;
  ref.read(hasGameInitiated.notifier).state = false;
  ref.read(myBricksProvider.notifier).reset();
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
        : GestureDetector(
            onTap: () => startGame(ref),
            child: Center(
              child: Container(
                alignment: const Alignment(0, -0.1),
                child: const Text(
                  'Tap to start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
  }
}
