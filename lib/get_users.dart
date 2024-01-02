import 'dart:convert';
import 'package:http/http.dart' as http;

class Score {
  final String playerName;
  final int totalGamesPlayed;
  final int totalWins;

  Score({
    required this.playerName,
    required this.totalGamesPlayed,
    required this.totalWins,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      playerName: json['PlayerName'],
      totalGamesPlayed: int.parse(json['GameCounter']),
      totalWins: int.parse(json['Wins']),
    );
  }

  static Future<List<Score>> fetchScores(String baseUrl) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Get_Scores.php')); // Update the PHP file name

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Score.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load scores');
      }
    } catch (e) {
      throw Exception('Error fetching scores: $e');
    }
  }
}
