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
final playerWidth = StateProvider<double>((ref) => 0.4);

/// Ball direction
enum Direction { up, down, right, left }

final ballXDirection = StateProvider<Direction>((ref) => Direction.left);
final ballYDirection = StateProvider<Direction>((ref) => Direction.up);

/// Brick variables
final brickWidth = StateProvider<double>((ref) => 0.4);
final brickHeight = StateProvider<double>((ref) => 0.05);
final brickX = StateProvider<double>((ref) => 0.0);
final brickY = StateProvider<double>((ref) => -0.9);
final isBrickBroken = StateProvider<bool>((ref) => false);
