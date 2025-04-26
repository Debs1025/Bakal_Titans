/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0015] Edit Profile
Description: This is where the sign up screen is coded where the user is required to
fill up fullname, email, password and confirm password*/


import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _bioController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Bio: ${_bioController.text}");

    Navigator.pop(context); // Close the page after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: "Bio",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveProfile,
              icon: Icon(Icons.save),
              label: Text("Save"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    home: EditProfilePage(),
  ));
}