import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchHistoryScreen extends StatefulWidget {
  final String puuid;
  final String subregion;

  const MatchHistoryScreen({
    Key? key,
    required this.puuid,
    required this.subregion,
  }) : super(key: key);

  @override
  _MatchHistoryScreenState createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  late Future<List<String>> _matchIdsFuture;

  @override
  void initState() {
    super.initState();
    _matchIdsFuture = _fetchMatchIds();
  }

  Future<List<String>> _fetchMatchIds() async {
    final response = await http.get(Uri.parse(
        'https://${widget.subregion}.api.riotgames.com/lol/match/v5/matches/by-puuid/${widget.puuid}/ids?api_key=RGAPI-f078a75c-5290-412b-9d39-f2eba8d1b0c3'));

    if (response.statusCode == 200) {
      final List<dynamic> matchIds = json.decode(response.body);
      return matchIds.map((id) => id.toString()).toList();
    } else {
      throw Exception('Failed to load match IDs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
        backgroundColor: Colors.blue, // Blue header color
        foregroundColor: Colors.white, // White text color
      ),
      body: FutureBuilder<List<String>>(
        future: _matchIdsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No matches found'));
          } else {
            final matchIds = snapshot.data!;
            return ListView.builder(
              itemCount: matchIds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Match ID: ${matchIds[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
