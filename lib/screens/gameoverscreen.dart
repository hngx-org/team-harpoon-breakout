import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:team_harpoon_breakout/game_functions/start_game.dart';
// import 'package:team_harpoon_breakout/game_widgets/ball.dart';
// import 'package:team_harpoon_breakout/game_widgets/player.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';

class GameOverScreen extends ConsumerWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameOver = ref.watch(isGameOver);
    return gameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: const Text(
              "G A M E  O V E R",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container();
  }
}
