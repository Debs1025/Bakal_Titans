/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0017] Sign Up Complete Screen
Description: A screen where it shows that the sign up is completed and goes back to login screen*/


import 'package:flutter/material.dart';
import './login.dart';

class PassCompleteScreen extends StatefulWidget {
  const PassCompleteScreen({super.key});

  @override
  State<PassCompleteScreen> createState() => _PassCompleteScreenState();
}

class _PassCompleteScreenState extends State<PassCompleteScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Center( 
      child: Container(
        width: double.infinity, 
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            // Check icon
            Image.asset(
              'assets/Password/complete.png',
              width: 100,
              height: 100,
              color: Colors.green,
            ),
              
              const SizedBox(height: 32),
              
              // Success text
              const Text(
                'Sign Up Complete',
                textAlign: TextAlign.center, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}