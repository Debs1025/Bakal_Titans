/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0014] Slash Screen
Description: This is where the 4th splash screen is coded*/


import 'package:flutter/material.dart';
import 'segui.dart';

class SulitScreen extends StatelessWidget {
  const SulitScreen({super.key});

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
                image: AssetImage('assets/sulit.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment(-0.3, -0.3),
                scale: 0.6,
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
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.95),
                ],
                stops: const [0.4, 0.85],
              ),
            ),
          ),

          // Back Arrow
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/arrow.png',
                  width: 32,
                  height: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Content Column
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.6),
              
              // Motivational Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Discipline Builds Real Strength",
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
                      MaterialPageRoute(builder: (context) => const SeguiScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 8, 1),
                    foregroundColor: const Color(0xFFFF8000),
                    minimumSize: const Size(double.infinity, 65),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(
                        color: Color(0xFFFF8000),
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