import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RockPaperScissorsApp());

}

class RockPaperScissorsApp extends StatelessWidget {
  const RockPaperScissorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        centerTitle: true,
          title: const Text('Rock, Paper, Scissors'),
        ),
        body: const RockPaperScissorsGame(),
      ),
    );
  }
}

class RockPaperScissorsGame extends StatefulWidget {
  const RockPaperScissorsGame({super.key});

  @override
  RockPaperScissorsGameState createState() => RockPaperScissorsGameState();
}

class RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
  final List<String> choices = ['rock', 'paper', 'scissors'];
  String userChoice = '';
  String computerChoice = '';
  String result = '';

  void makeComputerChoice() {
    final Random random = Random();
    int index = random.nextInt(3);
    computerChoice = choices[index];
  }

  void playGame(String userChoice) {
    makeComputerChoice();
    setState(() {
      this.userChoice = userChoice;
      if (userChoice == computerChoice) {
        result = 'It\'s a tie!';
      } else if (
      (userChoice == 'rock' && computerChoice == 'scissors') ||
          (userChoice == 'paper' && computerChoice == 'rock') ||
          (userChoice == 'scissors' && computerChoice == 'paper')) {
        result = 'You win!';
      } else {
        result = 'You lose!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        const Text(

          'Choose your move:',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        // Inside the _RockPaperScissorsGameState class
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: choices.map((choice) {

            return GestureDetector(
              onTap: () => playGame(choice),
              child: Image.asset(
                'assets/$choice.png',
                height: 80,
                width: 80,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 20),
        Text(
          'Your Choice: $userChoice',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          'Computer\'s Choice: $computerChoice',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Text(
          '   Result: \n $result',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
