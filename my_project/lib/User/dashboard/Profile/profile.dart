/* Authored by: Gerard Francis Pelonio
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature:[BKT-0021] Profile
Description: As a user, I want to be able to see my profile with my details*/


import 'package:flutter/material.dart';
import '../homescreen.dart';
import '../Search/search.dart';
import '../Analytics/analytics.dart';
import '../History/history.dart';
import 'editprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Navigate to the EditProfilePage when settings icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage  ()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 45),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              
              _buildAddressSection(),
              const SizedBox(height: 16),
              
              _buildStatisticsSection(),
              const SizedBox(height: 16),
              
              _buildTrainingsSection(),
              const SizedBox(height: 16),
              
              _buildPhotosSection(),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
  
  // Rest of your code remains the same...
  // Including _buildAddressSection, _buildStatisticsSection, _buildTrainingsSection, etc.
  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on, color: Colors.orange, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "123 Fitness Street, Gym City",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Statistics",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Show all",
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Calories", style: TextStyle(color: Colors.white)),
                  Text("160.5 kcal", style: TextStyle(color: Colors.orange)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Time", style: TextStyle(color: Colors.white)),
                  Text("1:03:30", style: TextStyle(color: Colors.orange)),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 8,
                          height: (index + 1) * 6.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"][index],
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trainings",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTrainingCard("Dumbbell Curls"),
              _buildTrainingCard("Wide Lat Pull"),
              _buildTrainingCard("Bench Press"),
              _buildTrainingCard("Squats"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Photos",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Show all",
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 75,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildPhoto(),
              _buildPhoto(),
              _buildPhoto(),
              _buildPhoto(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingCard(String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 55,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.fitness_center, color: Colors.orange),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(Icons.photo, color: Colors.orange),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 56,
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
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.home_filled, "Home", 0, HomeScreen()),
            _buildNavItem(context, Icons.search, "Search", 1, SearchPage()),
            _buildNavItem(context, Icons.bar_chart, "Analytics", 2, AnalyticsPage()),
            _buildNavItem(context, Icons.history, "History", 3, HistoryPage()),
            _buildNavItem(context, Icons.person, "Profile", 4, null),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index, Widget? destination) {
    final bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        if (!isSelected && destination != null) {
          Navigator.pushReplacement(
            context, 
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => destination,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 150),
            ),
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
              margin: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(1),
              ),
            )
          else
            const SizedBox(height: 4),
          Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.grey,
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}