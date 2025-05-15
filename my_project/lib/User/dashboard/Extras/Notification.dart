import 'package:flutter/material.dart';
import '../homescreen.dart';

class NotificationPage extends StatelessWidget {
  // Sample notification data - in a real app this would come from a database
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Workout Available",
      "message": "Check out the new FST-7 Back Workout program",
      "time": "2 mins ago",
      "isRead": false,
      "type": "new_workout"
    },
    {
      "title": "Workout Reminder",
      "message": "Don't forget your scheduled Full Body Workout today",
      "time": "1 hour ago",
      "isRead": false,
      "type": "reminder"
    },
    {
      "title": "Achievement Unlocked",
      "message": "Congratulations! You've completed 5 workouts this week",
      "time": "2 hours ago",
      "isRead": true,
      "type": "achievement"
    }
  ];

  NotificationPage({Key? key}) : super(key: key);

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
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Add mark all as read functionality
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(16),
              border: notification["isRead"] as bool
                  ? null
                  : Border.all(color: const Color(0xFFF97000), width: 1),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFF97000).withOpacity(0.1),
                child: Icon(
                  _getNotificationIcon(notification["type"] as String),
                  color: const Color(0xFFF97000),
                ),
              ),
              title: Text(
                notification["title"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    notification["message"]!,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification["time"]!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'new_workout':
        return Icons.fitness_center;
      case 'reminder':
        return Icons.alarm;
      case 'achievement':
        return Icons.emoji_events;
      default:
        return Icons.notifications;
    }
  }
}