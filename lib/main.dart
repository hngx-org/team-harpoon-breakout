import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_harpoon_breakout/screens/game_screen.dart';

import 'screens/menu.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  // Breakout game = Breakout();
  runApp(const ProviderScope(child: BreakoutGame()));
}

class BreakoutGame extends StatelessWidget {
  const BreakoutGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Valorax'),
      initialRoute: Splash.route,
      routes: {
        Splash.route: (context) => const Splash(),
        Menu.route: (context) => const Menu(),
        GameScreen.route: (context) => const GameScreen(),
      },
    );
  }
}
