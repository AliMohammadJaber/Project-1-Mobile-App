import 'package:flutter/material.dart';
import './game_page.dart';
import './get_users.dart';
import './multiplayer.dart';
import './leaderboards.dart';
import './login.dart';
import './register.dart';
import './globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const RockPaperScissorsGame(),
        '/multi': (context) => const Multi(),
        '/leader': (context) => const LeaderboardsStateful(),
        '/login' : (context) => LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Score> _scores = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: loggedInUsername == '' || loggedInUsername == null
            ? Row(
          children: [
            const Text(
              'Rock, Paper, Scissors',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(), // Add Spacer widget here
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome, $loggedInUsername', style: TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () async {
                loggedInUsername = '';
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [],
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
                  const Center(

                    child:

                    Text(
                      'Welcome to Rock Paper Scissors Game\n\n'
                          'You got 3 lives\n'
                          'Good Luck!\n',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/game');
                    },

                    child: const Text(
                      'Start Game',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/multi');
                    },
                    child: const Text(
                      'Multiplayer',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/leader');
                    },
                    child: const Text(
                      'Leaderboards',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
