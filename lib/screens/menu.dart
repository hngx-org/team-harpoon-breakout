import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_harpoon_breakout/screens/game_screen.dart';

class Menu extends StatelessWidget {
  static String route = '/';

  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Space Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              child: const Text(
                'Breakout',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(GameScreen.route),
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: const Text(
                  'Play Now',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              child: const Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => SystemNavigator.pop(),
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: const Text(
                  'QUIT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
