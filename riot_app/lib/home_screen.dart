import 'package:flutter/material.dart';
import 'summoner_search.dart';
import 'favorite_summoners.dart';
import 'settings.dart';
import 'user_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: UserStorage().getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Home');
            } else {
              return Text('Welcome, ${snapshot.data ?? 'User'}');
            }
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SummonerSearchScreen()),
                );
              },
              child: const Text('Summoner Search'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteSummonersScreen()),
                );
              },
              child: const Text('Favorite Summoners'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserStorage().removeUserName();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
