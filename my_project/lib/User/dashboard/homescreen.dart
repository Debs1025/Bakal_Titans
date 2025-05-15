/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0016] Home Page
Description: This is where the main dashboard is coded it contains 
profile icon, notification, favorites, workouts, descriptions, videos, 
navbar, nutrition tracker, and suggestion*/

import 'package:flutter/material.dart';
import 'History/history.dart';
import 'Search/search.dart';
import 'Analytics/analytics.dart';
import 'Profile/profile.dart'; 
import '../Sidebar/Sidebar.dart';
import '../Workout/Program.dart';
import 'Extras/Notification.dart';

/// Mainscreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSidebarOpen = false;

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
            _buildMainContent(),
            _buildBottomNav(),
            _buildFloatingActionButton(),
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
                onActivityTap: () {
                  _toggleSidebar();
                  // Add activity page navigation here
                },
                onFavoritesTap: () {
                  _toggleSidebar();
                  // Add favorites page navigation here
                },
                onSettingsTap: () {
                  _toggleSidebar();
                  // Add settings page navigation here
                },
                onLogoutTap: () {
                  _toggleSidebar();
                  // Add logout logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        _buildCategories(),
        _buildWorkoutList(),
      ],
    );
  }

  Widget _buildAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.black,
    pinned: true,
    expandedHeight: 120,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: const EdgeInsets.only(left: 24, bottom: 16, top: 20),
      title: const Text(
        'Workouts',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    leading: GestureDetector(
      onTap: _toggleSidebar,
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: 8,
          backgroundColor: Color(0xFF333333),
          child: Icon(
            Icons.person_outline,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 14,
          ),
        ),
      ),
    ),
    actions: [
      const Icon(Icons.bookmark_outline, color: Colors.white),
      const SizedBox(width: 20),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationPage()),
          );
        },
        child: const Icon(Icons.notifications_none, color: Color(0xFFF97000)),
      ),
      const SizedBox(width: 16),
    ],
  );
}

  Widget _buildCategories() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF333333), width: 1),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCategory("For You", isSelected: true),
            _buildCategory("Discover"),
            _buildCategory("Yoga"),
            _buildCategory("Strength"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 3,
            width: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFF97000),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
      ],
    );
  }

  Widget _buildWorkoutList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildWorkoutItems(),
        const SizedBox(height: 16),
        _buildStatistics(),
        _buildSuggestions(),
        const SizedBox(height: 80),
      ]),
    );
  }

  Widget _buildWorkoutItems() {
    return Column(
      children: [
        _buildWorkoutItem(
          "FST-7 Back Workout with Chris Bumstead x Hadi Choopan",
          "Active ~ Gym",
          "14 min",
          "assets/pic1.jpg",
        ),
        _buildWorkoutItem(
          "The Best Workout Routine BUILD MUSCLE & LOSE FAT",
          "Beginner ~ Gym",
          "12 min",
          "assets/pic2.jpg",
        ),
        _buildWorkoutItem(
          "Cristiano Ronaldo Bicep Workout",
          "Active ~ Gym",
          "18 min",
          "assets/pic3.jpg",
        ),
        _buildWorkoutItem(
          "Nathaniel Delfino Deadly Leg Workout Routine",
          "Active ~ Gym",
          "",
          "assets/pic4.png",
        ),
      ],
    );
  }

Widget _buildWorkoutItem(String title, String subtitle, String duration, String imagePath) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProgramDetail(
            title: title,
            duration: duration.replaceAll(RegExp(r'[^0-9]'), ''),
            description: subtitle,
            imagePath: imagePath,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                if (duration.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.bookmark_border, color: Colors.white, size: 24),
        ],
      ),
    ),
 );
}

  Widget _buildStatistics() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildCalorieCard(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutritionBox("102g", "Protein left", Icons.water_drop_outlined),
              _buildNutritionBox("250g", "Carbs left", Icons.spa_outlined),
              _buildNutritionBox("52g", "Fats left", Icons.settings),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieCard() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF666666),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1670',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Calories left',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.local_fire_department_outlined, color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionBox(String value, String label, IconData icon) {
    return Container(
      width: 120,
      height: 125,
      decoration: BoxDecoration(
        color: const Color(0xFF666666),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            "Suggestions",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage("assets/suggestion.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
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
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyticsPage()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
        } else if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
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

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 16,
      bottom: 84,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFF97000),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
