import 'package:flutter/material.dart';
import 'riot_api_service.dart';

class SummonerDetailsScreen extends StatefulWidget {
  final String summonerId;

  const SummonerDetailsScreen({super.key, required this.summonerId});

  @override
  _SummonerDetailsScreenState createState() => _SummonerDetailsScreenState();
}

class _SummonerDetailsScreenState extends State<SummonerDetailsScreen> {
  Map<String, dynamic>? _summonerDetails;

  @override
  void initState() {
    super.initState();
    _fetchSummonerDetails();
  }

  _fetchSummonerDetails() async {
    try {
      var details = await RiotApiService().fetchSummonerDetails(widget.summonerId);
      setState(() {
        _summonerDetails = details;
      });
    } catch (e) {
      setState(() {
        _summonerDetails = {'error': 'Failed to load summoner details'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summoner Details'),
      ),
      body: _summonerDetails == null
          ? const Center(child: CircularProgressIndicator())
          : _summonerDetails!.containsKey('error')
              ? Center(child: Text(_summonerDetails!['error'] as String))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${_summonerDetails!['name']}'),
                      Text('Level: ${_summonerDetails!['summonerLevel']}'),
                      // Add more details as needed
                    ],
                  ),
                ),
    );
  }
}
