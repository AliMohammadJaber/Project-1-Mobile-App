import 'package:flutter/material.dart';
import './get_users.dart';

void main() {
  runApp(const MaterialApp(
    home: LeaderboardsStateful(),
    debugShowCheckedModeBanner: false,
  ));
}

class LeaderboardsStateful extends StatefulWidget {
  const LeaderboardsStateful({Key? key}) : super(key: key);

  @override
  _LeaderboardsState createState() => _LeaderboardsState();
}

class _LeaderboardsState extends State<LeaderboardsStateful> {
  List<Score> _scores = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      const baseUrl = 'https://throwdowntrio.000webhostapp.com';
      List<Score> scores = await Score.fetchScores(baseUrl);
      print(scores);

      setState(() {
        _scores = scores;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching scores: $e');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to fetch scores. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Global Leaderboards'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  if (_isLoading) ...[
                    const CircularProgressIndicator(),
                  ] else if (_scores.isNotEmpty) ...[
                    const Text(
                      'Leaderboard Table:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: FittedBox(
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text('Player Name', style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Total Games Played', style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Total Wins', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          rows: _scores.map((score) {
                            return DataRow(cells: [
                              DataCell(Text(score.playerName, style: const TextStyle(color: Colors.white))),
                              DataCell(Text(score.totalGamesPlayed.toString(), style: const TextStyle(color: Colors.white))),
                              DataCell(Text(score.totalWins.toString(), style: const TextStyle(color: Colors.white))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}