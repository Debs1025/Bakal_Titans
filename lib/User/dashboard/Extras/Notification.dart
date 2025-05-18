/* Authored by: Erick De Belen
Company: Gerard Fitness Inc.
Project: Bakal Titans
Feature: [BKT-0008] Notification Screen
Description: A screen where users can check what notifications they have. */

import 'package:flutter/material.dart';
import '../homescreen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> _notifications = [
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

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

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
            onPressed: _markAllAsRead,
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
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return GestureDetector(
            onTap: () => _markAsRead(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
                border: notification["isRead"] as bool
                    ? null
                    : Border.all(color: const Color(0xFFF97000), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFF97000).withOpacity(0.1),
                      child: Icon(
                        _getNotificationIcon(notification["type"] as String),
                        color: const Color(0xFFF97000),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification["title"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                  ],
                ),
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