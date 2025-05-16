/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0016] Home Page
Description: This is where the main dashboard is coded it contains 
profile icon, notification, favorites, workouts, descriptions, videos, 
navbar, nutrition tracker, and suggestion*/


import 'package:flutter/material.dart';

/// Mainscreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track selected navigation item
  int _selectedIndex = 0;

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
          ],
        ),
      ),
    );
  }

  // Main scrollable content including app bar, categories, and workout list
  Widget _buildMainContent() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        _buildCategories(),
        _buildWorkoutList(),
      ],
    );
  }

  // App bar 
  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.black,
      pinned: true,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: 24, 
          bottom: 16,
          top: 20,
        ),
        title: const Text(
          'Workouts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: const Padding(
        padding: EdgeInsets.all(12.0),  
        child: CircleAvatar(
          radius: 8,  
          backgroundColor: Color(0xFF333333),
          child: Icon(
            Icons.person_outline, 
            color: Colors.white,
            size: 14,  
          ),
        ),
      ),
      actions: const [
        Icon(Icons.bookmark_outline, color: Colors.white),
        SizedBox(width: 20),
        Icon(Icons.notifications_none, color: Color(0xFFF97000)),
        SizedBox(width: 16),
      ],
    );
  }

  // Category section 
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

  // Individual category item 
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

  // Main workout list and statistics section
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

  // Collection of workout items
  Widget _buildWorkoutItems() {
    return Column(
      children: [
        _buildWorkoutItem(
          "FST-7 Back Workout with Chris Bumstead x Hadi Choopan",
          "Active ~ Gym",
          "14:14 min",
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

  // workout items
  Widget _buildWorkoutItem(String title, String subtitle, String duration, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout 
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
          // Workout details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
          // Bookmark icon
          const Icon(
            Icons.bookmark_border,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  // Statistics section with calorie and nutrition stats
  Widget _buildStatistics() {
    return Column(
      children: [
        // Calorie counter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildCalorieCard(),
        ),
        // Nutrition stats
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

  // Calorie counter card
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
                  child: Icon(
                    Icons.local_fire_department_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Nutrition stat box
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
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Suggestions 
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

  // Bottom navigation bar
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

  // Navigation item 
  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: 20,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF97000) : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Icon(
            icon,
            color: isSelected ? const Color(0xFFF97000) : Colors.grey,
            size: 22,
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

  // Floating action button
  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 16,
      bottom: 84,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFF97000),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}