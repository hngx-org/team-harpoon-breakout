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
final firstbrickX =
    StateProvider<double>((ref) => -1 + ref.read(wallGap.notifier).state);
final firstbrickY = StateProvider<double>((ref) => -0.9);
final brickHeight = StateProvider<double>((ref) => 0.05);
final brickWidth = StateProvider<double>((ref) => 0.4);
final brickBroken = StateProvider<bool>((ref) => false);
final noOfBricksInRow = StateProvider<double>((ref) => 3);
final wallGap = StateProvider<double>((ref) =>
    0.5 *
        (ref.read(noOfBricksInRow.notifier).state *
            ref.read(brickWidth.notifier).state) -
    (ref.read(noOfBricksInRow.notifier).state - 1) *
        ref.read(brickGap.notifier).state);
//ball Increment
final brickXIncrement = StateProvider<double>((ref) => 0.01);
final brickYIncrement = StateProvider<double>((ref) => 0.01);

//brick list

//brickGap
final brickGap = StateProvider<double>((ref) => 0.01);

/// Ball direction
enum Direction { up, down, left, right }

final ballYDirection = StateProvider<Direction>((ref) => Direction.down);
final ballXDirection = StateProvider<Direction>((ref) => Direction.left);

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
  }) : super([
          [
            firstBrickofX.state + 0 * (brickW.state + brickG.state),
            firstBrickofY.state,
            false,
          ],
          [
            firstBrickofX.state + 1 * (brickW.state + brickG.state),
            firstBrickofY.state,
            false,
          ],
          [
            firstBrickofX.state + 2 * (brickW.state + brickG.state),
            firstBrickofY.state,
            false,
          ],
        ]);
}

final myBricksProvider =
    StateNotifierProvider<MyBricksNotifier, List<List<dynamic>>>(
  (ref) => MyBricksNotifier(
    firstBrickofX: ref.watch(firstbrickX.notifier),
    firstBrickofY: ref.watch(firstbrickY.notifier),
    brickW: ref.watch(brickWidth.notifier),
    brickG: ref.watch(brickGap.notifier),
  ),
);
