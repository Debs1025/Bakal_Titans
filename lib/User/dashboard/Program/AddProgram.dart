/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0028] Add Workout Program Screen
Description: A screen where users can add their own workout program*/

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedLevel = 'Beginner';
  File? _imageFile;
  List<Map<String, String>> _exercises = [];

  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  void _addExercise() {
    setState(() {
      _exercises.add({
        'name': '',
        'sets': '',
        'reps': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(
              'assets/Program/backarrow.png',
              width: 24,
              height: 24,
              color: const Color(0xFFF97000),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Create Program',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail Section
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C1E),
                                borderRadius: BorderRadius.circular(12),
                                image: _imageFile != null
                                    ? DecorationImage(
                                        image: FileImage(_imageFile!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _imageFile == null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: Color(0xFFF97000),
                                          size: 48,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Add Thumbnail',
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Title Input
                          TextFormField(
                            controller: _titleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Program Title',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF333333)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFFF97000)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Level Selection
                          DropdownButtonFormField<String>(
                            value: _selectedLevel,
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: const Color(0xFF1C1C1E),
                            decoration: InputDecoration(
                              labelText: 'Level',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF333333)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFFF97000)),
                              ),
                            ),
                            items: levels.map((String level) {
                              return DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedLevel = newValue;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 24),

                          // Exercises Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Exercises',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _addExercise,
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xFFF97000),
                                ),
                                label: const Text(
                                  'Add Exercise',
                                  style: TextStyle(
                                    color: Color(0xFFF97000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Exercise List
                          ..._exercises.asMap().entries.map((entry) {
                            final int idx = entry.key;
                            return Card(
                              color: const Color(0xFF1C1C1E),
                              margin: const EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Exercise ${idx + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              _exercises.removeAt(idx);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      style: const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Exercise Name',
                                        labelStyle: TextStyle(color: Colors.grey[400]),
                                      ),
                                      onChanged: (value) {
                                        _exercises[idx]['name'] = value;
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            style: const TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelText: 'Sets',
                                              labelStyle: TextStyle(color: Colors.grey[400]),
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              _exercises[idx]['sets'] = value;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextFormField(
                                            style: const TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelText: 'Reps',
                                              labelStyle: TextStyle(color: Colors.grey[400]),
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              _exercises[idx]['reps'] = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Submit Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Add your save logic here
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Program',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}