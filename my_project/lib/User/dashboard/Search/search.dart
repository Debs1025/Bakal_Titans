import 'package:flutter/material.dart';
import '../homescreen.dart';
import '../History/history.dart';
import '../Analytics/analytics.dart';
import '../Profile/profile.dart';
import '../../Sidebar/Sidebar.dart'; 

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSidebarOpen = false;
  final int _currentIndex = 1;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
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
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF333333),
                        hintText: '',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Discover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      children: [
                        _buildWorkoutItem("FST-7 Back Workout with Chris Bumstead X Hadi Choopan"),
                        _buildWorkoutItem("Joseph Petalio Back and Bicep Workout"),
                        _buildWorkoutItem("Davonn's Deadly Tricep Workout"),
                        _buildWorkoutItem("Full week Gym Workout Plan | perfect plan for best result"),
                        _buildWorkoutItem("The Best Scienced - Base Workout"),
                        _buildWorkoutItem("Gerard Pelonio Surprise Leg Workout Routine"),
                        _buildWorkoutItem("Best Workout to make your Shoulder grow massive!"),
                        _buildWorkoutItem("Full Body Workout for Beginner"),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildBottomNav(context),
            ),
            if (_isSidebarOpen)
              GestureDetector(
                onTap: _toggleSidebar,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
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
                    MaterialPageRoute(builder: (context) => ProfilePage()),
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

  Widget _buildWorkoutItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
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
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index != _currentIndex) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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