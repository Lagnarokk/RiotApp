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
      var details = await RiotApiService().fetchMatchDetails(widget.matchId);
      setState(() {
        _matchDetails = details;
      });
    } catch (e) {
      setState(() {
        _matchDetails = {'error': 'Failed to load match details'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
      ),
      body: _matchDetails == null
          ? const Center(child: CircularProgressIndicator())
          : _matchDetails!.containsKey('error')
              ? Center(child: Text(_matchDetails!['error'] as String))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Match ID: ${_matchDetails!['matchId']}'),
                      // Add more details as needed
                    ],
                  ),
                ),
    );
  }
}
