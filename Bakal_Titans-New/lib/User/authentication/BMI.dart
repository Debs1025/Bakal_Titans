import 'package:flutter/material.dart';
import 'signupComplete.dart';
import '../../Firebase/userService.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final UserService _userService = UserService();
  double bmi = 0;
  String bmiCategory = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _calculateAndSaveBMI();
  }

 Future<void> _calculateAndSaveBMI() async {
  try {
    setState(() => isLoading = true);
    
    // Add timeout to Firebase call
    final userProfile = await _userService.getUserProfile().timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw 'Connection timeout. Please try again.',
    );
    
    if (userProfile == null) {
      throw 'No profile data found';
    }

    // Do calculation before Firebase update
    final weightStr = userProfile['weight']?.toString().replaceAll(' kg', '') ?? '0';
    final heightStr = userProfile['height']?.toString().replaceAll(' cm', '') ?? '0';
    
    final weight = double.parse(weightStr);
    final height = double.parse(heightStr);
    
    if (weight <= 0 || height <= 0) {
      throw 'Invalid weight or height values';
    }

    bmi = weight / ((height / 100) * (height / 100));
    bmi = double.parse(bmi.toStringAsFixed(1));
    bmiCategory = _getBMICategory(bmi);

    // Update UI first
    setState(() {
      errorMessage = null;
      isLoading = false;
    });

    // Then update Firebase in background
    _userService.updateBMI(
      bmi: bmi,
      bmiCategory: bmiCategory,
    );

  } catch (e) {
    setState(() {
      errorMessage = e.toString();
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
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
              _buildStepIndicator(),
              const Spacer(),
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

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: isLoading || errorMessage != null 
          ? null 
          : () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassCompleteScreen(),
                ),
                (route) => false,
              );
            },
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading || errorMessage != null 
            ? Colors.grey[800] 
            : const Color(0xFFFF8000),
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
            Text(
              isLoading ? 'Calculating...' : 'Continue',
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
}