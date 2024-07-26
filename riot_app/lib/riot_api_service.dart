import 'package:http/http.dart' as http;
import 'dart:convert';

class RiotApiService {
  final String _apiKey = 'YOUR_RIOT_API_KEY_HERE';
  final String _baseUrl = 'https://na1.api.riotgames.com/lol';

  Future<Map<String, dynamic>> fetchSummoner(String summonerName) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/summoner/v4/summoners/by-name/$summonerName?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load summoner');
    }
  }

  Future<List<dynamic>> fetchMatchHistory(String summonerId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/match/v4/matchlists/by-account/$summonerId?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['matches'];
    } else {
      throw Exception('Failed to load match history');
    }
  }

  Future<Map<String, dynamic>> fetchMatchDetails(String matchId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/match/v4/matches/$matchId?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load match details');
    }
  }
}
