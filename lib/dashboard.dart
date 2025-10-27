import 'package:flutter/material.dart';
import 'package:pixel_art/camera_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Camerascreen()),
                );
              },
              child: Text("Start"),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/character.png',
              height: 300, // taille du personnage
            ),
          ),
        ],
      ),
    );
  }
}
