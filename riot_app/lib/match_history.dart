import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchHistoryScreen extends StatefulWidget {
  final String puuid;
  final String subregion;

  const MatchHistoryScreen({super.key, required this.puuid, required this.subregion});

  @override
  _MatchHistoryScreenState createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  Future<List<Map<String, dynamic>>> _fetchMatchHistory() async {
    final matchIdsResponse = await http.get(Uri.parse(
        'https://${widget.subregion}.api.riotgames.com/lol/match/v5/matches/by-puuid/${widget.puuid}/ids?api_key=RGAPI-f078a75c-5290-412b-9d39-f2eba8d1b0c3'));

    if (matchIdsResponse.statusCode != 200) {
      throw Exception('Failed to load match IDs');
    }

    final matchIds = json.decode(matchIdsResponse.body);
    final matchDetailsList = <Map<String, dynamic>>[];

    // Fetch details for each match ID
    for (String matchId in matchIds.take(20)) {
      final matchDetailsResponse = await http.get(Uri.parse(
          'https://${widget.subregion}.api.riotgames.com/lol/match/v5/matches/$matchId?api_key=RGAPI-f078a75c-5290-412b-9d39-f2eba8d1b0c3'));

      if (matchDetailsResponse.statusCode == 200) {
        final matchDetails = json.decode(matchDetailsResponse.body);
        matchDetailsList.add(matchDetails);
      } else {
        throw Exception('Failed to load match details');
      }
    }

    return matchDetailsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
        backgroundColor: Colors.blue, // Blue header color
        foregroundColor: Colors.white, // White text color
      ),
      backgroundColor: Colors.grey[200], // Gray background color
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchMatchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No match history available'));
          } else {
            final matches = snapshot.data!;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                final gameMode = match['info']['gameMode'] ?? 'Unknown';
                final gameDuration = match['info']['gameDuration'] ?? 0;
                final durationMinutes = gameDuration ~/ 60;
                final durationSeconds = gameDuration % 60;

                return ListTile(
                  title: Text('Game Mode: $gameMode'),
                  subtitle: Text('Duration: $durationMinutes:$durationSeconds'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
