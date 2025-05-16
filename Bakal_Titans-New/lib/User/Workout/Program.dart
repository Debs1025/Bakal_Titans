import 'package:flutter/material.dart';
import '../dashboard/homescreen.dart';
import 'ProgramExercise.dart';

class ProgramDetail extends StatelessWidget {
  final String title;
  final String duration;
  final String description;
  final String imagePath;

  const ProgramDetail({
    Key? key,
    required this.title,
    required this.duration,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        ),
                        child: Image.asset(
                          'assets/Program/backarrow.png',
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/Program/favoritee.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Program Details
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title and Author
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'By Chris Bumsted',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Program Info Items
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem(
                            'assets/Program/time.png',
                            duration.isNotEmpty ? '$duration min' : 'No duration',
                            const Color(0xFFF97000),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoItem(
                            'assets/Program/detail.png',
                            'Contains Variety of back workouts',
                            const Color(0xFFF97000),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoItem(
                            'assets/Program/equipment.png',
                            'Equipment (Required)',
                            const Color(0xFFF97000),
                          ),
                          if (duration.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            _buildInfoItem(
                              'assets/Program/video.png',
                              'With Video',
                              const Color(0xFFF97000),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Start Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgramExercise(
                                  title: title,
                                  duration: duration,
                                  description: description,
                                  imagePath: imagePath,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF97000), // Orange background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Start',
                            style: TextStyle(
                              color: Colors.white, // White text
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String iconPath, String text, Color iconColor) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: iconColor,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}