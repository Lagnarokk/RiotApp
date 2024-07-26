import 'package:flutter/material.dart';
import 'riot_api_service.dart';
import 'match_details.dart';

class MatchHistoryScreen extends StatefulWidget {
  final String puuid;

  const MatchHistoryScreen({super.key, required this.puuid});

  @override
  _MatchHistoryScreenState createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  List<String>? _matches;

  @override
  void initState() {
    super.initState();
    _fetchMatchHistory();
  }

  _fetchMatchHistory() async {
    try {
      var matches = await RiotApiService().fetchMatchHistory(widget.puuid);
      setState(() {
        _matches = matches;
      });
    } catch (e) {
      setState(() {
        _matches = ['Failed to load match history'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
      ),
      body: _matches == null
          ? const Center(child: CircularProgressIndicator())
          : _matches!.contains('Failed to load match history')
              ? Center(child: Text('Failed to load match history'))
              : ListView.builder(
                  itemCount: _matches!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Match ${_matches![index]}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchDetailsScreen(matchId: _matches![index]),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
