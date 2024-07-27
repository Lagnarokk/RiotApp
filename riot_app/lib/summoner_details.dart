import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'riot_api_service.dart';
import 'favorite_summoners.dart';
import 'match_history.dart';

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
  late Future<Map<String, dynamic>> _summonerDetailsFuture;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _summonerDetailsFuture = _fetchSummonerDetails();
    _checkIfFavorite();
  }

  Future<Map<String, dynamic>> _fetchSummonerDetails() async {
    final riotApiService = RiotApiService();
    final puuid = await riotApiService.fetchPUUID(widget.region, widget.gameName, widget.tagLine);
    final summonerDetails = await riotApiService.fetchSummonerDetailsByPUUID(widget.subregion, puuid);
    return summonerDetails;
  }

  void _checkIfFavorite() {
    _isFavorite = favoriteSummoners.any((summoner) =>
      summoner['gameName'] == widget.gameName &&
      summoner['tagLine'] == widget.tagLine &&
      summoner['region'] == widget.region &&
      summoner['subregion'] == widget.subregion
    );
  }

  void _toggleFavorite(Map<String, dynamic> summonerData) {
    final profileIconId = summonerData['profileIconId'];
    final profileIconUrl = 'https://ddragon.leagueoflegends.com/cdn/11.24.1/img/profileicon/$profileIconId.png';

    final summoner = {
      'gameName': widget.gameName,
      'tagLine': widget.tagLine,
      'region': widget.region,
      'subregion': widget.subregion,
      'profileIconUrl': profileIconUrl,
    };

    setState(() {
      if (_isFavorite) {
        favoriteSummoners.removeWhere((s) =>
          s['gameName'] == widget.gameName &&
          s['tagLine'] == widget.tagLine &&
          s['region'] == widget.region &&
          s['subregion'] == widget.subregion
        );
      } else {
        favoriteSummoners.add(summoner);
      }
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summoner Details'),
        backgroundColor: Colors.blue, // Blue header color
        foregroundColor: Colors.white, // White text color
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _summonerDetailsFuture,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MatchHistoryScreen(
                                    puuid: summonerData['puuid'],
                                    subregion: widget.subregion,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text('Match History'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Blue tone for the button
                              foregroundColor: Colors.white, // White text color
                            ),
                          ),
                          SizedBox(width: 16),
                          // Toggle Favorite Button
                          ElevatedButton.icon(
                            onPressed: () {
                              _toggleFavorite(summonerData);
                            },
                            icon: Icon(_isFavorite ? Icons.star_border : Icons.star),
                            label: Text(_isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFavorite ? Colors.red : Colors.yellow[700], // Background color
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