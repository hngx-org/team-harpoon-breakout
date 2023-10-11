import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Player extends ConsumerWidget {
  const Player({super.key, required this.playerWidth, required this.playerX});

  final double playerX;
  final double playerWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment:
          Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width * playerWidth / 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
