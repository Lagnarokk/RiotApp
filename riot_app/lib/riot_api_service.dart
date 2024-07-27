import 'package:http/http.dart' as http;
import 'dart:convert';

class RiotApiService {
  final String _apiKey = 'RGAPI-f078a75c-5290-412b-9d39-f2eba8d1b0c3';

  Future<String> fetchPUUID(String region, String gameName, String tagLine) async {
    final response = await http.get(
      Uri.parse('https://$region.api.riotgames.com/riot/account/v1/accounts/by-riot-id/$gameName/$tagLine?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['puuid'];
    } else {
      throw Exception('Failed to load PUUID');
    }
  }

  Future<Map<String, dynamic>> fetchSummonerDetailsByPUUID(String subregion, String puuid) async {
    final response = await http.get(
      Uri.parse('https://$subregion.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/$puuid?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
