import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class RockPaperScissorsGame extends StatefulWidget {
  const RockPaperScissorsGame({Key? key}) : super(key: key);

  @override
  RockPaperScissorsGameState createState() => RockPaperScissorsGameState();
}

class RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
  final List<String> choices = ['rock', 'paper', 'scissors' ];
  String userChoice = '';
  String computerChoice = '';
  String result = '';
  int wins = 0;
  int losses = 0;
  int ties = 0;




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
        result = "It's a tie!";
        ties++;
      } else if (
      (userChoice == 'rock' && computerChoice == 'scissors') ||
          (userChoice == 'paper' && computerChoice == 'rock') ||
          (userChoice == 'scissors' && computerChoice == 'paper')) {
        result = 'You win!';
        wins++;
      } else {
        result = 'You lose!';
        losses++;
      }
      if (losses >= 3) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Game Over')),
              content: Text(
                'You got 3 losses. Better luck next time!\n\n'
                    '                        Wins: $wins \u{1F451}\n'
                    '                        Ties: $ties \u{2694}',
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text("Quit Game", style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () {
                        wins = 0;
                        losses = 0;
                        ties = 0;
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      child: const Text("Try Again", style: TextStyle(color: Colors.green)),
                    ),

                  ],
                ),
              ],
            );
          },
        ).then((value) {
          wins = 0;
          losses = 0;
          ties = 0;
          Navigator.popUntil(context, ModalRoute.withName('/'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock, Paper, Scissors'),

      ),

      body:
      Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Choose your move:',
                style: TextStyle(fontSize: 30,color:Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                'Your Loses: $losses',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: choices.map((choice) {
                  return ElevatedButton(
                    onPressed: () => playGame(choice),
                  style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 100),
                  ),
                    child: Image.asset(
                      'assets/$choice.png',
                      height: 100,
                      width: 100,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'Your Choice: $userChoice',
                style: const TextStyle(fontSize: 25 ,color:Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Computer's Choice: $computerChoice",
                style: const TextStyle(fontSize: 25 ,color:Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                '   Result: \n $result',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold ,color:Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
