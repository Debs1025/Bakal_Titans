/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0017] Body Type Screen
Description: A screen where users can choose what type of body they have */


import 'package:flutter/material.dart';
import '../../Firebase/userService.dart';
import 'WeightGoal.dart';

class BodyTypeScreen extends StatefulWidget {
  const BodyTypeScreen({super.key});

  @override
  State<BodyTypeScreen> createState() => _BodyTypeScreenState();
}

class _BodyTypeScreenState extends State<BodyTypeScreen> {
  String? selectedBodyType;
  final UserService _userService = UserService();

  final List<Map<String, String>> bodyTypes = [
  {
    'type': 'Ectomorph',
    'icon': 'assets/Profile/ectomorph.png',  
  },
  {
    'type': 'Endomorph',
    'icon': 'assets/Profile/endomorph.png', 
  },
  {
    'type': 'Mesomorph',
    'icon': 'assets/Profile/mesomorph.png',  
  },
];


Future<void> _handleContinue() async {
  if (selectedBodyType != null) {
    try {
      // Store in UserService temporary storage
      _userService.tempBodyType = selectedBodyType;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WeightGoalScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating body type: $e')),
      );
    }
  }
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose a Body Type',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Image.asset(
                      'assets/Profile/body.png',  
                      width: 48,
                      height: 48,
                      color: const Color(0xFFFF8000),
                    ),
                  const SizedBox(height: 24),
                  _buildBodyTypeOptions(),
                ],
              ),
            ),
            const Spacer(),
            _buildBottomSection(),
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

  Widget _buildBodyTypeOptions() {
    return Column(
      children: bodyTypes.map((bodyType) => 
        GestureDetector(
          onTap: () => setState(() => selectedBodyType = bodyType['type']),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(
                  bodyType['icon']!,
                  width: 24,
                  height: 24,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 16),
                Text(
                  bodyType['type']!,
                  style: TextStyle(
                    color: selectedBodyType == bodyType['type'] 
                        ? Colors.white 
                        : Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF8000),
                      width: 2,
                    ),
                  ),
                  child: selectedBodyType == bodyType['type']
                    ? const Center(
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Color(0xFFFF8000),
                        ),
                      )
                    : null,
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepIndicator(),
          const SizedBox(height: 16),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            color: index == 2 ? const Color(0xFFFF8000) : Colors.grey[800],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

Widget _buildContinueButton() {
  return ElevatedButton(
    onPressed: selectedBodyType != null ? _handleContinue : null, 
    style: ElevatedButton.styleFrom(
      backgroundColor: selectedBodyType != null ? const Color(0xFFFF8000) : Colors.grey[800],
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Image.asset(
          'assets/Profile/arrow.png',
          width: 16,
          height: 16,
          color: Colors.white,
        ),
      ],
    ),
  );
 }
}