// import 'package:flame/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/audio/game_audio.dart';
// import 'package:team_harpoon_breakout/audio/game_audio.dart';
import 'package:team_harpoon_breakout/game_functions/start_game.dart';
import 'package:team_harpoon_breakout/game_widgets/ball.dart';
// import 'package:team_harpoon_breakout/game_widgets/bricks.dart';
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
    // final brickx = ref.watch(firstbrickX);
    // final bricky = ref.watch(firstbrickY);
    final brickH = ref.watch(brickHeight);
    final brickW = ref.watch(brickWidth);
    final myBrick = ref.watch(myBricksProvider);
    // final brokenBrick = ref.watch(brickBroken);
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
                // GameWidget(game: GameAudio()),
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
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: myBrick.length,
                    itemBuilder: (context, index) {
                      return MyBrick(
                        brickH: brickH,
                        brickW: brickW,
                        brickx: myBrick[index][0],
                        bricky: myBrick[index][1],
                        brickBroken: myBrick[index][2],
                        bricksPerRow: 4,
                      );
                    },
                  ),
                ),
                // ListView(
                //   shrinkWrap: true,
                //   children: List.generate(
                //     (myBrick.length / 4).ceil(),
                //     (rowIndex) {
                //       return Row(
                //         children: List.generate(4, (brickIndex) {
                //           final index = myBrick.length - 1 - (rowIndex * 4 + brickIndex);
                //           if (index >= 0) {
                //             return myBrick[index][2]
                //                 ? Container()
                //                 : Padding(
                //                   padding: const EdgeInsets.all(5.0),
                //                   child: Container(
                //                       alignment: Alignment(
                //                         (myBrick[index][0] * brickW + myBrick[index][0] * brickW * (4 - 1)),
                //                         myBrick[index][1],
                //                       ),
                //                       child: ClipRRect(
                //                         borderRadius: BorderRadius.circular(5),
                //                         child: Container(
                //                           height: MediaQuery.of(context).size.height * brickH / 2,
                //                           width: MediaQuery.of(context).size.width * brickW / 2,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                     ),
                //                 );
                //           } else {
                //             return Container();
                //           }
                //         }),
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
