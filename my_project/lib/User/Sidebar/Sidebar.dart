import 'package:flutter/material.dart';
import '../authentication/login.dart';
import '../dashboard/Extras/Activity.dart';
import '../dashboard/Extras/Favorites.dart';
import '../dashboard/Extras/Notification.dart';
import '../dashboard/Extras/Terms.dart';

class Sidebar extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onActivityTap;
  final Function()? onFavoritesTap;
  final Function()? onSettingsTap;
  final Function()? onLogoutTap;
  final Function()? onNotificationTap; 

  const Sidebar({
    Key? key,
    this.onProfileTap,
    this.onActivityTap,
    this.onFavoritesTap,
    this.onSettingsTap,
    this.onLogoutTap,
    this.onNotificationTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: const Color(0xFF1C1C1E),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.fitness_center, color: Color(0xFFF97000)),
                const SizedBox(width: 8),
                const Text(
                  'Bakal Titans',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileTile(),
          _buildMenuItem(context, Icons.local_activity, 'Activity', onActivityTap),
          _buildMenuItem(context, Icons.favorite_border, 'Favorites', onFavoritesTap),
          _buildMenuItem(context, Icons.description_outlined, 'Terms and Policies', onSettingsTap),
          _buildMenuItem(context, Icons.notifications_outlined, 'Notifications', onNotificationTap),
          const Spacer(),
          _buildMenuItem(context, Icons.logout, 'Logout', onLogoutTap, color: Colors.red),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileTile() {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFFF97000),
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        'Profile',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

    Widget _buildMenuItem(BuildContext context, IconData icon, String title, Function()? onTap, {Color color = Colors.white}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      title,
      style: TextStyle(color: color),
    ),
    onTap: () {
      if (title == 'Notifications') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationPage()),
        );
      } else if (title == 'Logout') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      } else if (title == 'Activity') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityPage()),
        );
      } else if (title == 'Favorites') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
      } else if (title == 'Terms and Policies') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
        );
      } else {
        onTap?.call();
      }
    },
  );
 }
}