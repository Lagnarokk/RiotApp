import 'package:flutter/material.dart';
import 'riot_api_service.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String matchId;

  const MatchDetailsScreen({super.key, required this.matchId});

  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  Map<String, dynamic>? _matchDetails;

  @override
  void initState() {
    super.initState();
    _fetchMatchDetails();
  }

  _fetchMatchDetails() async {
    try {
      var matchDetails = await RiotApiService().fetchMatchDetails(widget.matchId);
      setState(() {
        _matchDetails = matchDetails;
      });
    } catch (e) {
      setState(() {
        _matchDetails = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
      ),
      body: Center(
        child: _matchDetails == null
            ? const CircularProgressIndicator()
            : ListView(
                children: [
                  Text('Game ID: ${_matchDetails!['gameId']}'),
                  Text('Game Duration: ${_matchDetails!['gameDuration']} seconds'),
                  ...(_matchDetails!['participants'] as List<dynamic>).map((participant) {
                    return ListTile(
                      title: Text(participant['summonerName']),
                      subtitle: Text('Champion: ${participant['championId']}, KDA: ${participant['kills']}/${participant['deaths']}/${participant['assists']}'),
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }
}
