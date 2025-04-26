/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0014] Slash Screen
Description: This is where the 2nd splash screen is coded*/

import 'package:flutter/material.dart';
import 'delfino.dart';

// Second onboarding screen showing workout motivation
class DebelenScreen extends StatelessWidget {
  const DebelenScreen({super.key});

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
                image: AssetImage('assets/debelen.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment(0.2, -0.7),
                scale: 0.6,
              ),
            ),
          ),

          // Dark gradient overlay
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

          // Back button
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
          
          // Main content column
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.6),
              
              // Motivational text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Stronger Every Single Day",
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

              // Pagination dots
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
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Next button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DelfinoScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color(0xFFF97000),
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Color(0xFFF97000),
                      fontSize: 16,
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