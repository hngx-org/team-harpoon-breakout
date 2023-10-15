
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:team_harpoon_breakout/bricks_breaker.dart';
import 'package:team_harpoon_breakout/utils/constants.dart';
import 'package:team_harpoon_breakout/widgets/game_button.dart';
import 'package:team_harpoon_breakout/widgets/game_score.dart';

class GamePause extends StatelessWidget {
  const GamePause({
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'PAUSE',
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
              GameButton(
                onPressed: () {
                  (game as BricksBreaker).togglePauseState();
                },
                title: 'CONTINUE',
                color: continueButtonColor,
                width: 200,
              ),
              const SizedBox(height: 20),
              GameButton(
                onPressed: () {
                  (game as BricksBreaker).resetGame();
                },
                title: 'RESTART',
                color: restartButtonColor,
                width: 200,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
