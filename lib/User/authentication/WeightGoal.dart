/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0003] Weight Goal Screen
Description: A screen where users see their weight goal*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'BMI.dart';
import '../../Firebase/userService.dart';

class WeightGoalScreen extends StatefulWidget {
  const WeightGoalScreen({super.key});

  @override
  State<WeightGoalScreen> createState() => _WeightGoalScreenState();
}

class _WeightGoalScreenState extends State<WeightGoalScreen> {
  final TextEditingController weightController = TextEditingController();
  bool isWeightValid = false;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    weightController.addListener(_validateWeight);
  }

  void _validateWeight() {
    setState(() {
      final weight = double.tryParse(weightController.text);
      isWeightValid = weight != null && weight > 0;
    });
  }

  @override
  void dispose() {
    weightController.removeListener(_validateWeight);
    weightController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (isWeightValid) {
      try {
        // Store in UserService temporary storage
        _userService.tempWeightGoal = '${weightController.text} lbs';
        
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BMIScreen()),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating weight goal: $e')),
        );
      }
    }
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

  Widget _buildWeightGoalInput() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Profile/scale.png',
            width: 48,
            height: 48,
            color: const Color(0xFFFF8000),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Weight Goal',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: weightController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '180.0',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (_) => _validateWeight(),
                  ),
                ),
                const Text(
                  'lbs',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
            color: index == 3 ? const Color(0xFFFF8000) : Colors.grey[800],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: isWeightValid ? _handleContinue : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isWeightValid ? const Color(0xFFFF8000) : Colors.grey[800],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            const Text(
              'Select Weight Goal',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            _buildWeightGoalInput(),
            const Spacer(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }
}