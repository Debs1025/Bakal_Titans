/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0020] Verification Screen
Description: A screen where users enter their verification code that they receive from their gmail */


import 'package:flutter/material.dart';
import '../login.dart';
import 'enterpass.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String> code = List.filled(5, '');
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFFF8000),
                    size: 24,
                  ),
                ),
              ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    Image.asset(
                      'assets/Password/Icon.png',
                      width: 80,
                      height: 80,
                      color: const Color(0xFFFF8000),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Check your email Text
                    const Text(
                      'Check your email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Email verification text
                    Text(
                      'We sent a verification code to ${widget.email}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Verification code fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) => SizedBox(
                          width: 50,
                          child: TextField(
                            focusNode: focusNodes[index],
                            enableSuggestions: false,  
                            autocorrect: false,     
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFF8000)),
                              ),
                              counterText: "", // Changed this line to hide the counter
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 4) {
                                focusNodes[index + 1].requestFocus();
                              }
                              setState(() {
                                code[index] = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                  // Verify code button
                   ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnterPasswordScreen(),
                          ),
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
                        'Verify code',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Didn't receive code text
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Add resend code logic here
                        },
                        child: Text(
                          'Didn\'t receive the code? Click to resend',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    
                    // Back to Login
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Password/Backarrow.png',
                            width: 16,
                            height: 16,
                            color: const Color(0xFFFF8000),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Back to Log in',
                            style: TextStyle(
                              color: Color(0xFFFF8000),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}