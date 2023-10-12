import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  const Brick(
      {super.key,
      required this.brickXState,
      required this.brickYState,
      required this.brickHeightState,
      required this.brickWidthState,
      required this.isBrickBroken});

  final double brickXState;
  final double brickYState;
  final double brickHeightState;
  final double brickWidthState;
  final bool isBrickBroken;

  @override
  Widget build(BuildContext context) {
    return isBrickBroken
        ? Container()
        : Container(
            alignment: Alignment(brickXState, brickYState),
            child: Container(
              height: MediaQuery.of(context).size.height * brickHeightState / 2,
              width: MediaQuery.of(context).size.width * brickWidthState / 2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          );
  }
}
