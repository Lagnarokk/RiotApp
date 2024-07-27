import 'package:flutter/material.dart';
import 'summoner_details.dart';

List<Map<String, dynamic>> favoriteSummoners = [];

class FavoriteSummonersScreen extends StatelessWidget {
  const FavoriteSummonersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Summoners'),
        backgroundColor: Colors.blue, // Blue background color for AppBar
        foregroundColor: Colors.white, // White text color for AppBar
      ),
      body: favoriteSummoners.isEmpty
          ? const Center(
              child: Text('No favorite summoners added yet.'),
            )
          : ListView.builder(
              itemCount: favoriteSummoners.length,
              itemBuilder: (context, index) {
                final summoner = favoriteSummoners[index];
                return ListTile(
                  leading: Image.network(summoner['profileIconUrl']),
                  title: Text('${summoner['gameName']}#${summoner['tagLine']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummonerDetailsScreen(
                          gameName: summoner['gameName'],
                          tagLine: summoner['tagLine'],
                          region: summoner['region'],
                          subregion: summoner['subregion'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
