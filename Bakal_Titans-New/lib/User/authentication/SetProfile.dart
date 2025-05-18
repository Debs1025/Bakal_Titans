/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0017] Set Profile Screen
Description: A screen where user fill up their birthdate, gender, weight and height */


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ActivityLevel.dart';
import '../../Firebase/userService.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  // Controllers
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final UserService _userService = UserService();

  // State variables
  String? selectedBirthdate;
  String? selectedGender;
  String? selectedWeight;
  String? selectedHeight;

  // Constants
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> genders = ['Male', 'Female', 'Other'];
  

void _handleContinue() async {
  if (_isFormComplete()) {
    try {
      await _userService.saveUserProfile(
        birthdate: selectedBirthdate!,
        gender: selectedGender!,
        weight: selectedWeight!,
        height: selectedHeight!,
      );

      if (!mounted) return;
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ActivityLevelScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 32),
                      _buildProfileFields(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // Header Section
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

  // Title Section
  Widget _buildTitle() {
    return const Text(
      'Set Your Profile',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Profile Fields Section
  Widget _buildProfileFields() {
  return Center( 
    child: Container(
      constraints: const BoxConstraints(maxWidth: 340), 
      child: Column(
        children: [
          const SizedBox(height: 20),  
          _buildProfileField(
            icon: 'assets/Profile/birthdate.png',
            text: 'Enter birthdate',
            selectedValue: selectedBirthdate,
            onTap: _showBirthdateDialog,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            icon: 'assets/Profile/gender.png',
            text: 'Enter gender',
            selectedValue: selectedGender,
            onTap: _showGenderDialog,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            icon: 'assets/Profile/weight.png',
            text: 'Enter weight',
            selectedValue: selectedWeight,
            onTap: _showWeightDialog,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            icon: 'assets/Profile/height.png',
            text: 'Enter height',
            selectedValue: selectedHeight,
            onTap: _showHeightDialog,
          ),
        ],
      ),
    ),
  );
}

  Widget _buildProfileField({
    required String icon,
    required String text,
    required VoidCallback onTap,
    String? selectedValue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 24,
              height: 24,
              color: Colors.grey[400],
            ),
            const SizedBox(width: 16),
            Text(
              selectedValue ?? text,
              style: TextStyle(
                color: selectedValue != null ? Colors.white : Colors.grey[400],
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/Profile/arrow.png',
              width: 16,
              height: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Section
  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          _buildStepIndicator(),
          const SizedBox(height: 24),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFFF8000),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(3, (index) => [
          Container(
            width: 24,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
        ]).expand((element) => element).toList(),
      ],
    );
  }

Widget _buildContinueButton() {
  return ElevatedButton(
    onPressed: _isFormComplete() ? _handleContinue : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: _isFormComplete() ? const Color(0xFFFF8000) : Colors.grey[800],
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

  // Dialog Methods
  void _showBirthdateDialog() {
    String? month;
    String? day;
    String? year;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Birthdate',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Color(0xFFFF8000),
                    ),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xFFFF8000),
                                onPrimary: Colors.white,
                                surface: Color(0xFF303030),
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: Colors.grey[900],
                            ),
                            child: child!,
                          );
                        },
                      );
                      
                      if (picked != null) {
                        setState(() {
                          selectedBirthdate = 
                              '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (month != null && day != null && year != null) {
                        setState(() {
                          selectedBirthdate = '$month $day, $year';
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Color(0xFFFF8000)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          content: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        children: months.map((m) => Text(
                          m,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: month == m ? const Color(0xFFFF8000) : Colors.white,
                          ),
                        )).toList(),
                        onSelectedItemChanged: (index) {
                          month = months[index];
                        },
                      ),
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        children: List.generate(31, (index) => Text(
                          '${index + 1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: day == '${index + 1}' ? const Color(0xFFFF8000) : Colors.white,
                          ),
                        )),
                        onSelectedItemChanged: (index) {
                          day = '${index + 1}';
                        },
                      ),
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        children: List.generate(100, (index) => Text(
                          '${2024 - index}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: year == '${2024 - index}' ? const Color(0xFFFF8000) : Colors.white,
                          ),
                        )),
                        onSelectedItemChanged: (index) {
                          year = '${2024 - index}';
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[700]!),
                      bottom: BorderSide(color: Colors.grey[700]!),
                    ),
                  ),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Select Gender',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: genders.map((gender) => ListTile(
              title: Text(
                gender,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  selectedGender = gender;
                });
                Navigator.pop(context);
              },
            )).toList(),
          ),
        );
      },
    );
  }

  void _showWeightDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enter Weight',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  if (weightController.text.isNotEmpty) {
                    setState(() {
                      selectedWeight = '${weightController.text} kg';
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Color(0xFFFF8000)),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Weight in kg',
              hintStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF8000)),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        );
      },
    );
  }

  void _showHeightDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enter Height',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  if (heightController.text.isNotEmpty) {
                    setState(() {
                      selectedHeight = '${heightController.text} cm';
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Color(0xFFFF8000)),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Height in cm',
              hintStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF8000)),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        );
      },
    );
  }

  bool _isFormComplete() {
    return selectedBirthdate != null && 
           selectedGender != null && 
           selectedWeight != null && 
           selectedHeight != null;
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}