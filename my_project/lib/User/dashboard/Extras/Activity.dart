import 'package:flutter/material.dart';
import '../homescreen.dart';

class ActivityPage extends StatelessWidget {
  // Sample activity data - in a real app this would come from a database
  final List<Map<String, dynamic>> activities = [
    {
      "title": "FST-7 Back Workout",
      "type": "Strength Training",
      "duration": "45 mins",
      "date": "Today",
      "calories": "350",
      "image": "assets/pic1.jpg"
    },
    {
      "title": "Full Body Workout",
      "type": "Circuit Training",
      "duration": "30 mins", 
      "date": "Yesterday",
      "calories": "280",
      "image": "assets/pic2.jpg"
    },
    {
      "title": "Leg Day Routine",
      "type": "Strength Training",
      "duration": "50 mins",
      "date": "2 days ago",
      "calories": "400",
      "image": "assets/pic3.jpg"
    }
  ];

  ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/Profile/backarrow.png',
            width: 24,
            height: 24,
            color: const Color(0xFFF97000),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
        title: const Text(
          'Activity',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildActivityStats(),
          Expanded(
            child: _buildActivityList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Workouts', '12', Icons.fitness_center),
          _buildVerticalDivider(),
          _buildStatItem('Hours', '8.5', Icons.timer),
          _buildVerticalDivider(),
          _buildStatItem('Kcal', '2400', Icons.local_fire_department),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[800],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFF97000), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  activity["image"]!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity["type"]!,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildActivityDetail(
                          Icons.timer,
                          activity["duration"]!,
                        ),
                        const SizedBox(width: 16),
                        _buildActivityDetail(
                          Icons.local_fire_department,
                          "${activity["calories"]} kcal",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  activity["date"]!,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFF97000), size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}