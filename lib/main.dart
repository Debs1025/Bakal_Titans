/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0014] Slash Screen
Description: This is where the main splash screen is coded where the logo in its app name is shown*/

import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'splash/pelonio.dart';
import 'Firebase/firebase_option.dart';

// Entry point of the application
// Runs the root widget MyApp
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        useMaterial3: true,  
      ),
      home: const SplashScreen(),  
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigates to OnboardingScreen when tapped
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // Stack allows widgets to be placed on top of each other
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Center widget contains the logo and app name
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo image
                  Image.asset(
                    'assets/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 15),  // Spacing between logo and text
                  // App name text
                  const Text(
                    'BAKAL TITANS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Text(
                  'Click anywhere',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}