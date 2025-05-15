/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0015] Edit Profile
Description: This is where the edit profile screen is coded where the user can update
their profile information including personal details, address details, and body activity details */

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for text fields
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _genderController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _regionController = TextEditingController();
  
  // Body activity details
  String bodyType = 'Ectomorph';
  String weightGoal = '180lbs';
  String activityLevel = 'No Activity';
  String currentBMI = '25.9';

  @override
  void dispose() {
    // Dispose all controllers
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _genderController.dispose();
    _zipcodeController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Here you would typically save the profile data to your backend or local storage
    
    // For now, just print the values and navigate back
    print("Name: ${_nameController.text}");
    print("Bio: ${_bioController.text}");
    // Print other fields...
    
    Navigator.pop(context); // Return to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[800],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Change Photo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Personal Details Section
              const Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Name Field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // Bio Field
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              
              // Age, Height, Weight, Gender Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _genderController,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Address Details Section
              const Text(
                'Address Details',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Zipcode Field
              TextField(
                controller: _zipcodeController,
                decoration: const InputDecoration(
                  labelText: 'Zipcode',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              
              // Street Name Field
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // City Field
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // Region Field
              TextField(
                controller: _regionController,
                decoration: const InputDecoration(
                  labelText: 'Region',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              
              const SizedBox(height: 32),
              
              // Body Activity Details Section
              const Text(
                'Body Activity Details',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Body Activity Fields with updated styling that matches the image
              _buildBodyActivityField(
                'Body Type', 
                bodyType, 
                Colors.orange
              ),
              const SizedBox(height: 10),
              
              _buildBodyActivityField(
                'Weight Goal', 
                weightGoal, 
                Colors.orange
              ),
              const SizedBox(height: 10),
              
              _buildBodyActivityField(
                'Activity Level', 
                activityLevel, 
                Colors.orange
              ),
              const SizedBox(height: 10),
              
              _buildBodyActivityField(
                'Current BMI', 
                currentBMI, 
                Colors.orange
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBodyActivityField(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF333333), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}