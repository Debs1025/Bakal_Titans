import 'package:flutter/material.dart';
import '../authentication/login.dart';

class Sidebar extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onActivityTap;
  final Function()? onFavoritesTap;
  final Function()? onSettingsTap;
  final Function()? onLogoutTap;

  const Sidebar({
    Key? key,
    this.onProfileTap,
    this.onActivityTap,
    this.onFavoritesTap,
    this.onSettingsTap,
    this.onLogoutTap,
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
          _buildMenuItem(context, Icons.settings, 'Settings', onSettingsTap),
          _buildMenuItem(context, Icons.description_outlined, 'Terms and Policies', onSettingsTap),
          const Spacer(),
          _buildMenuItem(context, Icons.logout, 'Logout', onLogoutTap, color: Colors.red),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileTile() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFF333333),
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: const Text(
        'Jayce Betrayer',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: const Text(
        '324 Followers',
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onProfileTap,
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Function()? onTap, {Color color = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      onTap: title == 'Logout' ? () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      } : onTap,
    );
  }
}