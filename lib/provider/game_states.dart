import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Ball's x-position
final ballX = StateProvider<double>((ref) => 0.0);

/// Ball's y-position
final ballY = StateProvider<double>((ref) => 0.0);

/// Game has started
final hasGameInitiated = StateProvider<bool>((ref) => false);

/// is Game over
final hasGameEnded = StateProvider<bool>((ref) => false);

/// Player position X
final playerPositionX = StateProvider<double>((ref) => -0.2);

/// Player width
final playerWidth = StateProvider<double>((ref) => 0.3);

///GameStatus
final isGameOver = StateProvider<bool>((ref) => false);

//BrickElements
final firstbrickX = StateProvider<double>((ref) => -1 + ref.read(wallGap.notifier).state);
final firstbrickY = StateProvider<double>((ref) => -0.9);
final brickHeight = StateProvider<double>((ref) => 0.05);
final brickWidth = StateProvider<double>((ref) => 0.4);
final brickBroken = StateProvider<bool>((ref) => false);
final noOfBricksInRow = StateProvider<double>((ref) => 4);
final wallGap = StateProvider<double>((ref) =>
    0.5 * (ref.read(noOfBricksInRow.notifier).state * ref.read(brickWidth.notifier).state) -
    (ref.read(noOfBricksInRow.notifier).state - 1) * ref.read(brickGap.notifier).state);
//ball Increment
final brickXIncrement = StateProvider<double>((ref) => 0.02);
final brickYIncrement = StateProvider<double>((ref) => 0.01);

//brick list

//brickGap
final brickGap = StateProvider<double>((ref) => 0.01);

/// Ball direction
enum Direction { up, down, left, right }

//LRUD distance
final leftsideDist = StateProvider<double>((ref) => 0.0);
final rightsideDist = StateProvider<double>((ref) => 0.0);
final topsideDist = StateProvider<double>((ref) => 0.0);
final bottomsideDist = StateProvider<double>((ref) => 0.0);

//ball direction
final ballYDirection = StateProvider<Direction>((ref) => Direction.down);
final ballXDirection = StateProvider<Direction>((ref) => Direction.left);

//Pause Game
final gamePaused = StateProvider<bool>((ref) => false);

//game Resume
final gameResume = StateProvider<bool>((ref) => false);

//levelcompleted
final levelCompleted = StateProvider.autoDispose<bool>((ref) => false);

class MyBricksNotifier extends StateNotifier<List<List<dynamic>>> {
  final StateController<double> firstBrickofX;
  final StateController<double> firstBrickofY;
  final StateController<double> brickW;
  final StateController<double> brickG;

  MyBricksNotifier({
    required this.firstBrickofX,
    required this.firstBrickofY,
    required this.brickW,
    required this.brickG,
    required int numberOfBricks, // Add this parameter
  }) : super(generateBricks(
          firstBrickofX.state,
          firstBrickofY.state,
          brickW.state,
          brickG.state,
          numberOfBricks,
        ));

  static List<List<dynamic>> generateBricks(
    double startX,
    double startY,
    double brickWidth,
    double brickGap,
    int numberOfBricks,
  ) {
    List<List<dynamic>> bricks = [];
    for (int i = 0; i < numberOfBricks; i++) {
      bricks.add([startX + i * (brickWidth + brickGap), startY, false]);
    }
    return bricks;
  }

  void reset(int numberOfBricks) {
    state = generateBricks(
      firstBrickofX.state,
      firstBrickofY.state,
      brickW.state,
      brickG.state,
      numberOfBricks,
    );
  }
}

final myBricksProvider = StateNotifierProvider<MyBricksNotifier, List<List<dynamic>>>(
  (ref) => MyBricksNotifier(
    firstBrickofX: ref.watch(firstbrickX.notifier),
    firstBrickofY: ref.watch(firstbrickY.notifier),
    brickW: ref.watch(brickWidth.notifier),
    brickG: ref.watch(brickGap.notifier),
    numberOfBricks: 10,
  ),
);

final highestScore = ValueNotifier<List<int>>([]);

// class HighestSCoreNotifier extends StateNotifier<List<int>> {
//   HighestSCoreNotifier() : super([]);

//   void addItem(int score) {
//     state = [...state, score];
//   }
//     int getMaxValue() {
//     if (state.isEmpty) {
//       return 0; 
//     }
//     return state.reduce((max, value) => max > value ? max : value);
//   }
// }