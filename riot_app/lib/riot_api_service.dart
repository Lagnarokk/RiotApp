import 'package:http/http.dart' as http;
import 'dart:convert';

class RiotApiService {
  final String _apiKey = 'RGAPI-2af735d3-e40f-49ae-997b-a7f984b07c98';
  final String _baseUrl = 'https://na1.api.riotgames.com';

  Future<Map<String, dynamic>> fetchSummonerDetails(String summonerId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lol/summoner/v4/summoners/$summonerId?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  Future<List<String>> fetchMatchHistory(String puuid) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lol/match/v5/matches/by-puuid/$puuid/ids?api_key=$_apiKey'),
    );
    List<dynamic> data = _handleResponse(response);
    return List<String>.from(data);
  }

  Future<Map<String, dynamic>> fetchMatchDetails(String matchId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lol/match/v5/matches/$matchId?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  Future<List<dynamic>> fetchChampions() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lol/platform/v3/champion-rotations?api_key=$_apiKey'),
    );
    Map<String, dynamic> data = _handleResponse(response);
    return List<dynamic>.from(data['champions'] ?? []);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
