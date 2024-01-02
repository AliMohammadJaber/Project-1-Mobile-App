import 'package:flutter/material.dart';
import 'main.dart';
class Multi extends StatelessWidget {
  const Multi({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Comming Soon"),
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
                        'Multiplayer Feature\n Comming Soon\n',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        'Go Back',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      )
    );
  }
}
