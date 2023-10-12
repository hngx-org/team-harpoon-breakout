import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/game_functions/start_game.dart';
import 'package:team_harpoon_breakout/game_widgets/ball.dart';
import 'package:team_harpoon_breakout/game_widgets/player.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';
import 'package:team_harpoon_breakout/screens/bricks.dart';
import 'package:team_harpoon_breakout/screens/gamePauseScreen.dart';
import 'package:team_harpoon_breakout/screens/gameoverscreen.dart';

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

    //brickElements
    final brickx = ref.watch(firstbrickX);
    final bricky = ref.watch(firstbrickY);
    final brickH = ref.watch(brickHeight);
    final brickW = ref.watch(brickWidth);
    final myBrick = ref.watch(myBricksProvider);
    final brokenBrick = ref.watch(brickBroken);

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
        onDoubleTap: () {
          if (ref.watch(isGameOver)) {
          } else if (ref.watch(hasGameInitiated) == false) {
          } else {
            ref.read(gamePaused.notifier).state = true;
          }
        },
     
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

                //Game Status
                GameOverScreen(function: () => resetGame(ref)),

                //Paused Game Screen
                const GamePauseScreen(),

                // Game ball
                Ball(ballpositionX: ballpositionX, ballpositionY: ballpositionY),

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

                MyBrick(
                  brickH: brickH,
                  brickW: brickW,
                  brickx: myBrick[0][0],
                  bricky: myBrick[0][1],
                  brickBroken: myBrick[0][2],
                ),
                MyBrick(
                  brickH: brickH,
                  brickW: brickW,
                  brickx: myBrick[1][0],
                  bricky: myBrick[1][1],
                  brickBroken: myBrick[1][2],
                ),
                MyBrick(
                  brickH: brickH,
                  brickW: brickW,
                  brickx: myBrick[2][0],
                  bricky: myBrick[2][1],
                  brickBroken: myBrick[2][2],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
