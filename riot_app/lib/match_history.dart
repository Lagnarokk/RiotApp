import 'package:flutter/material.dart';
import 'riot_api_service.dart';
import 'match_details.dart';

class MatchHistoryScreen extends StatefulWidget {
  final String summonerId;

  const MatchHistoryScreen({super.key, required this.summonerId});

  @override
  _MatchHistoryScreenState createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  List<dynamic>? _matchHistory;

  @override
  void initState() {
    super.initState();
    _fetchMatchHistory();
  }

  _fetchMatchHistory() async {
    try {
      var matchHistory = await RiotApiService().fetchMatchHistory(widget.summonerId);
      setState(() {
        _matchHistory = matchHistory;
      });
    } catch (e) {
      setState(() {
        _matchHistory = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
      ),
      body: Center(
        child: _matchHistory == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _matchHistory!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Match ${_matchHistory![index]['gameId']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetailsScreen(matchId: _matchHistory![index]['gameId']),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
