
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:team_harpoon_breakout/bricks_breaker.dart';
import 'package:team_harpoon_breakout/widgets/game_score.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 25, 14, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 32,
            ),
            onPressed: () {
              (game as BricksBreaker).togglePauseState();
            },
          ),
          GameScore(
            game: game,
          ),
          IconButton(
            icon: const Icon(
              Icons.bolt,
              size: 32,
            ),
            onPressed: () {
              (game as BricksBreaker).increaseBallSpeed();
            },
          ),
        ],
      ),
    );
  }
}
