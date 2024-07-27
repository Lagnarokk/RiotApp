import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'riot_api_service.dart';

class SummonerDetailsScreen extends StatefulWidget {
  final String gameName;
  final String tagLine;
  final String region;
  final String subregion;

  SummonerDetailsScreen({
    required this.gameName,
    required this.tagLine,
    required this.region,
    required this.subregion,
  });

  @override
  _SummonerDetailsScreenState createState() => _SummonerDetailsScreenState();
}

class _SummonerDetailsScreenState extends State<SummonerDetailsScreen> {
  Future<Map<String, dynamic>> _fetchSummonerDetails() async {
    final riotApiService = RiotApiService();
    final puuid = await riotApiService.fetchPUUID(widget.region, widget.gameName, widget.tagLine);
    final summonerDetails = await riotApiService.fetchSummonerDetailsByPUUID(widget.subregion, puuid);
    return summonerDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summoner Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchSummonerDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final summonerData = snapshot.data!;
            final profileIconId = summonerData['profileIconId'];
            final profileIconUrl = 'https://ddragon.leagueoflegends.com/cdn/11.24.1/img/profileicon/$profileIconId.png';
            return Container(
              color: Colors.grey[200], // Light grey background color
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Icon
                      Image.network(profileIconUrl, width: 100, height: 100),
                      SizedBox(height: 16),
                      // Summoner Name and Level
                      Column(
                        children: [
                          Text('${widget.gameName}#${widget.tagLine}', 
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text('Level: ${summonerData['summonerLevel']}', 
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Matches Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to the match screen
                              Navigator.pushNamed(context, '/match_screen');
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text('Match History'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Background color
                              foregroundColor: Colors.white, // Text color
                            ),
                          ),
                          SizedBox(width: 16),
                          // Add to Favorites Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add to favorites
                            },
                            icon: Icon(Icons.star),
                            label: Text('Add to Favorites'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[700], // Background color
                              foregroundColor: Colors.white, // Text color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
