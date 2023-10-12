import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/game_functions/start_game.dart';
import 'package:team_harpoon_breakout/game_widgets/ball.dart';
import 'package:team_harpoon_breakout/game_widgets/player.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';
import 'package:team_harpoon_breakout/screens/gameoverscreen.dart';

class MyBrick extends ConsumerWidget {
  final brickH;
  final brickW;
  final brickx;
  final bricky;
  final brickBroken;
  const MyBrick(this.brickH, this.brickW, this.brickx, this.bricky, this.brickBroken, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return brickBroken
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.9),
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
