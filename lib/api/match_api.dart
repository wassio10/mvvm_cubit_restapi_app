import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match_model.dart';

class MatchApi {
  static const String url =
      'https://raw.githubusercontent.com/openfootball/football.json/master/2024-25/en.1.json';

  static Future<List<MatchModel>> fetchMatches() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        final List<dynamic> matches = data['matches'] ?? [];

        List<MatchModel> allMatches = [];

        for (var match in matches) {
          allMatches.add(MatchModel.fromJson(match));
        }

        return allMatches;
      } catch (e) {
        throw Exception('Error parsing match data: $e');
      }
    } else {
      throw Exception(
        'Failed to load matches. Status code: ${response.statusCode}',
      );
    }
  }
}
