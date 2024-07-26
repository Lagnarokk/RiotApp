import 'package:flutter/material.dart';
import 'summoner_details.dart';

class SummonerSearchScreen extends StatefulWidget {
  const SummonerSearchScreen({super.key});

  @override
  _SummonerSearchScreenState createState() => _SummonerSearchScreenState();
}

class _SummonerSearchScreenState extends State<SummonerSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _searchSummoner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummonerDetailsScreen(summonerId: _controller.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summoner Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Summoner ID',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchSummoner,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
