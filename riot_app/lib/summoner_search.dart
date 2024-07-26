import 'package:flutter/material.dart';
import 'riot_api_service.dart';
import 'connectivity_service.dart';
import 'summoner_details.dart';

class SummonerSearchScreen extends StatefulWidget {
  const SummonerSearchScreen({super.key});

  @override
  _SummonerSearchScreenState createState() => _SummonerSearchScreenState();
}

class _SummonerSearchScreenState extends State<SummonerSearchScreen> {
  final TextEditingController _summonerController = TextEditingController();
  String? _summonerData;

  _searchSummoner() async {
    if (await ConnectivityService().isConnected()) {
      try {
        var summonerData = await RiotApiService().fetchSummoner(_summonerController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummonerDetailsScreen(summonerData: summonerData),
          ),
        );
      } catch (e) {
        setState(() {
          _summonerData = 'Error: $e';
        });
      }
    } else {
      setState(() {
        _summonerData = 'No internet connection';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summoner Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _summonerController,
              decoration: const InputDecoration(labelText: 'Summoner Name'),
            ),
            ElevatedButton(
              onPressed: _searchSummoner,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            _summonerData != null
                ? Text(_summonerData!)
                : const Text('Enter a summoner name to search'),
          ],
        ),
      ),
    );
  }
}
