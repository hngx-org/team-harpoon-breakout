import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/provider/game_states.dart';

class GameHighestScore extends ConsumerWidget {
  const GameHighestScore({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<List<int>>(
        valueListenable: highestScore,
        builder: (context, value, child) {
          final highest = value.reduce((max, value) => max > value ? max : value);
          return Text(
            highest.toString(),
            style: const TextStyle(
              fontSize: 30,
            ),
          );
        });
  }
}
