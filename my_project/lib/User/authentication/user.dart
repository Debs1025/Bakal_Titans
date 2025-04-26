/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-001] Account Creation
Description: This is where a user is prompt which user he/she is whether a user or a coach*/


import 'package:flutter/material.dart';
import '../../splash/segui.dart';
import 'login.dart';

class UserScreen extends StatelessWidget {  
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Textured Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/hexagon.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black87, 
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Arrow
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SeguiScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 40, top: 40),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: const Color(0xFFFF8000),
                      size: 24,
                    ),
                  ),
                ),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo 
                      Image.asset(
                        'assets/logo.png',
                        width: 80,
                        height: 80,
                        color: const Color(0xFFFF8000),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Brand name
                      const Text(
                        'BAKAL TITANS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 100),
                      
                      // User Type Question
                      const Text(
                        'What are you?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // User button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8000),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'User',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      // Coach button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to coach registration 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8000),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Coach',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}