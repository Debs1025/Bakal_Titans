/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0018] BMI Screen
Description: A screen where users can check what their BMI is*/

import 'package:flutter/material.dart';
import '../../Firebase/userService.dart';
import 'signupComplete.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final UserService _userService = UserService();
  double bmi = 22.5; // Default value
  String bmiCategory = '';
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    bmiCategory = _getBMICategory(bmi);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF8000),
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your BMI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildBMIDisplay(),
                  ],
                ),
              ),
              const Spacer(),
              _buildStepIndicator(),
              _buildBottomSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              'assets/Profile/backarrow.png',
              width: 24,
              height: 24,
              color: const Color(0xFFFF8000),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Profile/icon.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xFFFF8000),
                ),
                const SizedBox(width: 8),
                const Text(
                  'BAKAL TITANS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildBMIDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Profile/bmi.png',
            width: 48,
            height: 48,
            color: const Color(0xFFFF8000),
          ),
          const SizedBox(height: 24),
          Text(
            bmi.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8000),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              bmiCategory,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 24,
            height: 4,
            decoration: BoxDecoration(
              color: index == 4 ? const Color(0xFFFF8000) : Colors.grey[800],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildBottomSection() {
  return Container(
    padding: const EdgeInsets.all(24),
    child: ElevatedButton(
      onPressed: !isLoading ? () async {
        setState(() => isLoading = true);
        
        try {
          // Store BMI data
          _userService.tempBMI = bmi;
          _userService.tempBMICategory = bmiCategory;

          // Create user with all stored data
          await _userService.createUserWithAllData();
          
          if (!mounted) return;
          
          // Navigate to completion screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PassCompleteScreen()),
          );
        } catch (e) {
          print('Error creating account: $e');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating account: $e')),
          );
        } finally {
          if (mounted) setState(() => isLoading = false);
        }
      } : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: !isLoading ? const Color(0xFFFF8000) : Colors.grey[800],
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLoading ? 'Creating Account...' : 'Sign Up',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isLoading) ...[
            const SizedBox(width: 8),
            Image.asset(
              'assets/Profile/arrow.png',
              width: 16,
              height: 16,
              color: Colors.white,
            ),
          ],
        ],
      ),
    ),
  );
 }
}