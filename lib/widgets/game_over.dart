import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/bricks_breaker.dart';
import 'package:team_harpoon_breakout/gamesessions_highest_score.dart';
import 'package:team_harpoon_breakout/utils/constants.dart';
import 'package:team_harpoon_breakout/widgets/game_button.dart';
import 'package:team_harpoon_breakout/widgets/game_score.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(panelColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer(builder: (context, ref, child) {
            // Future(() {
            //   ref.watch(gameSessionsControllerProvider.notifier).addGameSession(
            //         score: (game as BricksBreaker).gameManager.score.value,
            //       );
            // });

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'GAME OVER',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'SCORE',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                GameScore(
                  game: game,
                ),
                const SizedBox(height: 20),
                const Text(
                  'HIGHEST SCORE',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
               const GameHighestScore(),
                const SizedBox(height: 20),
                GameButton(
                  onPressed: () {
                    (game as BricksBreaker).resetGame();
                  },
                  title: 'TRY AGAIN',
                  color: continueButtonColor,
                  width: 200,
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ),
      ),
    );
  }
}
