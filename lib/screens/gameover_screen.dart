import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameOverScreen extends ConsumerWidget {
  const GameOverScreen({super.key, required this.isGameOver});

  final bool isGameOver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.1),
            child: const Text(
              'Game Over',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        : Container();
  }
}
