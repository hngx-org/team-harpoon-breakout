import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Ball's x-position
final ballX = StateProvider<double>((ref) => 0.0);

/// Ball's y-position
final ballY = StateProvider<double>((ref) => 0.0);

/// Game has started
final hasGameInitiated = StateProvider<bool>((ref) => false);

/// Player position X
final playerPositionX = StateProvider<double>((ref) => 0.0);

/// Player width
final playerWidth = StateProvider<double>((ref) => 0.3);

///GameStatus
final isGameOver = StateProvider<bool>((ref) => false);

//BrickElements
final brickX = StateProvider<double>((ref) => 0);
final brickY = StateProvider<double>((ref) => -0.9);
final brickHeight = StateProvider<double>((ref) => 0.05);
final brickWidth = StateProvider<double>((ref) => 0.4);
final brickBroken = StateProvider<bool>((ref) => false);

//ball Increment
final brickXIncrement = StateProvider<double>((ref) => 0.01);
final brickYIncrement = StateProvider<double>((ref) => 0.01);

/// Ball direction
enum Direction { up, down, left, right }

final ballYDirection = StateProvider<Direction>((ref) => Direction.down);
final ballXDirection = StateProvider<Direction>((ref) => Direction.up);
