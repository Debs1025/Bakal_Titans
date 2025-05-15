/* Authored by: Gerard Francis Pelonio
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0022] History
Description: As a user, I want to be able to view history of my workouts and searches */

import 'package:flutter/material.dart';
import '../homescreen.dart'; 
import '../Search/search.dart';
import '../Analytics/analytics.dart';
import '../Profile/profile.dart'; 
import '../../Workout/Program.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 3;

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
                hintText: "Search history",
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[900],
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              style: const TextStyle(color: Colors.white),
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
                        contentPadding: EdgeInsets.zero,
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
                            // Handle delete
                            setState(() {
                              historyItems.removeAt(index);
                            });
                          },
                          child: Image.asset(
                            "assets/History/trash.png",
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey, height: 1),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),

            // Recent Workouts Grid
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Workouts",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            Expanded(
              flex: 2,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgramDetail(
                            title: item["title"]!,
                            duration: "45", // You can add duration to your historyItems if needed
                            description: "Strength Training",
                            imagePath: item["image"]!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF1C1C1E),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                item["image"]!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${item["title"]!.split(' ').take(3).join(' ')}...',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
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
            _buildNavItem(context, Icons.home_filled, "Home", 0),
            _buildNavItem(context, Icons.search, "Search", 1),
            _buildNavItem(context, Icons.bar_chart, "Analytics", 2),
            _buildNavItem(context, Icons.history, "History", 3),
            _buildNavItem(context, Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index != _selectedIndex) {
          Widget page;
          switch (index) {
            case 0:
              page = const HomeScreen();
              break;
            case 1:
              page = SearchPage();
              break;
            case 2:
              page = AnalyticsPage();
              break;
            case 3:
              page = HistoryPage();
              break;
            case 4:
              page = const ProfilePage();
              break;
            default:
              return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
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
                color: const Color(0xFFF97000),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          Icon(
            icon,
            color: isSelected ? const Color(0xFFF97000) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFF97000) : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}