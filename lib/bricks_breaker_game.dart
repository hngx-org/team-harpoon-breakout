import 'package:flutter/material.dart';
import 'package:team_harpoon_breakout/game_page.dart';

import 'package:team_harpoon_breakout/utils/constants.dart';

class BricksBreakerGame extends StatelessWidget {
  const BricksBreakerGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: gameTitle,
      theme: ThemeData.dark(),
      home: const GamePage(title: gameTitle),
    );
  }
}
