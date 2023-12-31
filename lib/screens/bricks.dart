import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:team_harpoon_breakout/game_functions/start_game.dart';
// import 'package:team_harpoon_breakout/game_widgets/ball.dart';
// import 'package:team_harpoon_breakout/game_widgets/player.dart';
// import 'package:team_harpoon_breakout/provider/game_states.dart';
// import 'package:team_harpoon_breakout/screens/gameoverscreen.dart';

class MyBrick extends ConsumerWidget {
  final double brickH;
  final double brickW;
  final double brickx;
  final double bricky;
  final bool brickBroken;
  final int bricksPerRow;
  const MyBrick(
      {required this.brickH,
      required this.brickW,
      required this.brickx,
      required this.bricky,
      required this.brickBroken,
      required this.bricksPerRow,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return brickBroken
        ? Container()
        : Container(
          width: MediaQuery.of(context).size.width,
            alignment: Alignment(
              (brickx * brickW + brickx * brickW * (bricksPerRow - 1)),
              bricky,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickH / 2,
                width: MediaQuery.of(context).size.width * brickW / 2,
                color: Colors.white,
              ),
            ),
          );
  }
}
