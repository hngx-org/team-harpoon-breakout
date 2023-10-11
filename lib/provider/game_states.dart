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

/// Ball direction
enum Direction { up, down }

final ballDirection = StateProvider<Direction>((ref) => Direction.down);
