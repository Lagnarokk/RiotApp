import 'package:flutter/material.dart';
import 'match_history.dart';

class SummonerDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> summonerData;

  const SummonerDetailsScreen({super.key, required this.summonerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summoner Details: ${summonerData['name']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Summoner ID: ${summonerData['id']}'),
            Text('Summoner Level: ${summonerData['summonerLevel']}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchHistoryScreen(summonerId: summonerData['id']),
                  ),
                );
              },
              child: const Text('View Match History'),
            ),
          ],
        ),
      ),
    );
  }
}
