/* Authored by: Gerard Francis Pelonio
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0022] History
Description: As a user, I want to be able to view history of my workouts and searches */

import 'package:flutter/material.dart';
import '../homescreen.dart'; // Import HomeScreen for navigation
import '../Search/search.dart'; // Import SearchPage for navigation
import '../Analytics/analytics.dart'; // Import AnalyticsPage for navigation
import '../Profile/profile.dart'; // Import ProfilePage for navigation

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 3; // Set the default index to History

  final List<Map<String, String>> historyItems = [
    {
      "title": "FST-7 Back Workout with Chris Bumstead X Hadi Choopan",
      "image": "assets/History/cbum.png",
    },
    {
      "title": "The Best Workout Routine BUILD MUSCLE & LOSE FAT",
      "image": "assets/History/suii.png",
    },
    {
      "title": "Nathaniel Delfino Shocking Workout Routine",
      "image": "assets/History/debs.png",
    },
    {
      "title": "Harold Delos Santos Hybrid Workout Routine for 30 mins",
      "image": "assets/History/gilard.png",
    },
    {
      "title": "The Best Scienced - Base Workout",
      "image": "assets/History/suii.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "History",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "", // Empty hint
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[900],
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            // History List
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          item["title"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            // Handle delete action
                          },
                          child: Image.asset(
                            "assets/History/trash.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey, height: 8),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Bottom Images
            SizedBox(
              height: 200,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item["image"]!,
                          width: 120,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item["title"]!.split(' ').take(3).join(' ')}...',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: const Border(
          top: BorderSide(color: Color(0xFF333333), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.home_filled, "Home", 0, _selectedIndex),
            _buildNavItem(context, Icons.search, "Search", 1, _selectedIndex),
            _buildNavItem(context, Icons.bar_chart, "Analytics", 2, _selectedIndex),
            _buildNavItem(context, Icons.history, "History", 3, _selectedIndex),
            _buildNavItem(context, Icons.person, "Profile", 4, _selectedIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index, int currentIndex) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index != currentIndex) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AnalyticsPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected)
            Container(
              height: 2,
              width: 20,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}