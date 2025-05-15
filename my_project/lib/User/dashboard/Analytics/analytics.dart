/* Authored by: Gerard Francis Pelonio
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-005] Progress Tracking
Description: As a user, I want to track my fitness progress so that I can see improvements over time.*/

import 'package:flutter/material.dart';
import '../History/history.dart';
import '../Search/search.dart';
import '../homescreen.dart';
import '../Profile/profile.dart';
import '../../Sidebar/Sidebar.dart';
import '../Extras/Notification.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  bool _isSidebarOpen = false;
  int _selectedIndex = 2;
  int _selectedFilterIndex = 3;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 2) {
      // Already on AnalyticsPage
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                leading: GestureDetector(
                  onTap: _toggleSidebar,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF333333),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationPage()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.notifications_none,
                            color: Color(0xFFF97000),
                            size: 24,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 2,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF97000),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              body: Column(
                children: [
                  // Toggle Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ToggleButtons(
                          isSelected: [
                            _selectedFilterIndex == 0,
                            _selectedFilterIndex == 1,
                            _selectedFilterIndex == 2,
                            _selectedFilterIndex == 3,
                          ],
                          onPressed: (int index) {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          fillColor: Colors.grey[400],
                          color: Colors.white,
                          constraints: const BoxConstraints(
                            minWidth: 70,
                            minHeight: 40,
                          ),
                          children: const [
                            Text("Week", style: TextStyle(color: Colors.white)),
                            Text("Month", style: TextStyle(color: Colors.white)),
                            Text("Year", style: TextStyle(color: Colors.white)),
                            Text("All", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Graphs Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/Analytics/graph1.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 300,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/Analytics/graph2.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildBottomNav(),
            ),

            // Sidebar overlay
            if (_isSidebarOpen)
              GestureDetector(
                onTap: _toggleSidebar,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),

            // Animated Sidebar
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isSidebarOpen ? 0 : -MediaQuery.of(context).size.width * 0.7,
              top: 0,
              bottom: 0,
              child: Sidebar(
                onProfileTap: () {
                  _toggleSidebar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                onActivityTap: _toggleSidebar,
                onFavoritesTap: _toggleSidebar,
                onSettingsTap: _toggleSidebar,
                onLogoutTap: _toggleSidebar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
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
            _buildNavItem(Icons.home_filled, "Home", 0),
            _buildNavItem(Icons.search, "Search", 1),
            _buildNavItem(Icons.bar_chart, "Analytics", 2),
            _buildNavItem(Icons.history, "History", 3),
            _buildNavItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
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