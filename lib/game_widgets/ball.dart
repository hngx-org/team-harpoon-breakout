import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({
    super.key,
    required this.ballpositionX,
    required this.ballpositionY,
  });

  final double ballpositionX;
  final double ballpositionY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballpositionX, ballpositionY),
      child: Container(
        height: 20,
        width: 20,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
