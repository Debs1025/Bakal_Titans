/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0014] Slash Screen
Description: This is where the 1st splash screen is coded 
where the 1st image of the splash is showsn, the text, and the 
next button*/


import 'package:flutter/material.dart';
import 'debelen.dart';

// Splash Screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pelonio.png'),
                fit: BoxFit.cover,
                alignment: Alignment(0.4, -0.10),
              ),
            ),
          ),
          
          // Darker Gradient Overlay 
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),  
                  Colors.black.withOpacity(0.98), 
                ],
                stops: const [0.4, 0.85],
              ),
            ),
          ),
          
          // Main Content Column
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.6),
              
              // Motivational Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Push Harder, Grow\nStronger",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              
              const Spacer(), 
              
              // Pagination Dots 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Next Button 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DebelenScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 8, 1),
                    foregroundColor: const Color(0xFFF97000), 
                    minimumSize: const Size(double.infinity, 65),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(
                        color: Color(0xFFF97000), 
                        width: 2.0,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40), 
            ],
          ),
        ],
      ),
    );
  }
}