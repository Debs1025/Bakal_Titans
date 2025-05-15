import 'package:flutter/material.dart';
import '../homescreen.dart';

class FavoritesPage extends StatelessWidget {
  // Sample favorites data - in a real app this would come from a database
  final List<Map<String, dynamic>> favorites = [
    {
      "title": "FST-7 Back Workout",
      "type": "Strength Training",
      "duration": "45 mins",
      "trainer": "Chris Bumstead",
      "image": "assets/pic1.jpg"
    },
    {
      "title": "Full Body Workout",
      "type": "Circuit Training",
      "duration": "30 mins",
      "trainer": "Jeff Cavaliere",
      "image": "assets/pic2.jpg"
    },
    {
      "title": "Leg Day Routine",
      "type": "Strength Training",
      "duration": "50 mins",
      "trainer": "Ronnie Coleman",
      "image": "assets/pic3.jpg"
    }
  ];

  FavoritesPage({Key? key}) : super(key: key);

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
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index];
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
                    favorite["image"]!,
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
                        favorite["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        favorite["type"]!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "By ${favorite["trainer"]!}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildProgramDetail(
                        Icons.timer,
                        favorite["duration"]!,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Color(0xFFF97000),
                  ),
                  onPressed: () {
                    // Add unfavorite functionality here
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgramDetail(IconData icon, String text) {
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