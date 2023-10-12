import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/audio/game_audio.dart';
import 'package:team_harpoon_breakout/game_functions/start_game.dart';
import 'package:team_harpoon_breakout/game_widgets/ball.dart';
import 'package:team_harpoon_breakout/game_widgets/bricks.dart';
import 'package:team_harpoon_breakout/game_widgets/player.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';
import 'package:team_harpoon_breakout/screens/gameover_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  static String route = '/gamescreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    // ball coordinates
    final ballpositionX = ref.watch(ballX);
    final ballpositionY = ref.watch(ballY);

    // has game started?
    final hasGameStarted = ref.watch(hasGameInitiated);

    // player coordinates
    final playerX = ref.watch(playerPositionX);
    final playerWidthState = ref.watch(playerWidth);

    // brick variables
    final brickWidthState = ref.watch(brickWidth);
    final brickHeightState = ref.watch(brickHeight);
    final brickXState = ref.watch(brickX);
    final brickYState = ref.watch(brickY);
    final brickBrokenState = ref.watch(isBrickBroken);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft(ref);
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight(ref);
        }
      },
      child: GestureDetector(
        onTap: () => startGame(ref),
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Space Background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Start game
                PlayScreen(hasGameInitiated: hasGameStarted),

                // Game over
                GameOverScreen(isGameOver: ref.watch(hasGameEnded)),

                // Game ball
                Ball(
                    ballpositionX: ballpositionX, ballpositionY: ballpositionY),

                // Player
                Player(playerWidth: playerWidthState, playerX: playerX),

                /// playerX
                Container(
                  alignment: Alignment(playerX, 0.9),
                  child: Container(
                    color: Colors.red,
                    width: 4,
                    height: 15,
                  ),
                ),

                /// playerX
                Container(
                  alignment: Alignment(playerX + playerWidthState, 0.9),
                  child: Container(
                    color: Colors.green,
                    width: 4,
                    height: 15,
                  ),
                ),

                /// bricks
                Brick(
                  brickXState: brickXState,
                  brickYState: brickYState,
                  brickHeightState: brickHeightState,
                  brickWidthState: brickWidthState,
                  isBrickBroken: brickBrokenState,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
