import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../History/history.dart';
import '../Search/search.dart';
import '../homescreen.dart';
import '../Profile/profile.dart';
import '../../Sidebar/Sidebar.dart';
import '../Extras/Notification.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  bool _isSidebarOpen = false;
  int _selectedIndex = 2;
  int _selectedFilterIndex = 3;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryPage()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.black,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: _toggleSidebar,
                    child: const Padding(
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
                  ),
                  actions: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NotificationPage()),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              Icons.notifications_none,
                              color: Color(0xFFF97000),
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 2,
                          child: Container(
                            height: 14,
                            width: 14,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF97000),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Text(
                      'Analytics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Center(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ToggleButtons(
                          isSelected: List.generate(
                            4,
                            (index) => _selectedFilterIndex == index,
                          ),
                          onPressed: (int index) {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          fillColor: Colors.grey[400],
                          color: Colors.white,
                          selectedColor: Colors.black,
                          constraints: const BoxConstraints(
                            minWidth: 70,
                            minHeight: 40,
                          ),
                          children: const [
                            Text("Week"),
                            Text("Month"),
                            Text("Year"),
                            Text("All"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          _buildWorkoutActivityChart(),
                          const SizedBox(height: 16),
                          _buildTotalBodyChart(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildBottomNav(),
            ),
            if (_isSidebarOpen)
              GestureDetector(
                onTap: _toggleSidebar,
                child: Container(color: Colors.black.withOpacity(0.7)),
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
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                onActivityTap: _toggleSidebar,
                onFavoritesTap: _toggleSidebar,
                onSettingsTap: _toggleSidebar,
                onLogoutTap: _toggleSidebar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutActivityChart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Workout Activity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: Colors.grey, fontSize: 12);
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = 'May';
                            break;
                          case 1:
                            text = 'Jun';
                            break;
                          case 2:
                            text = 'Jul';
                            break;
                          case 3:
                            text = 'Aug';
                            break;
                        }
                        return Text(text, style: style);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: _createBarGroups(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFFF97000), 'Total Body'),
              const SizedBox(width: 16),
              _buildLegendItem(Colors.grey[600]!, 'Weights'),
              const SizedBox(width: 16),
              _buildLegendItem(Colors.grey[400]!, 'Cardio'),
            ],
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      _createBarGroup(0, [30, 40, 20]),
      _createBarGroup(1, [20, 30, 10]),
      _createBarGroup(2, [80, 50, 30]),
      _createBarGroup(3, [60, 40, 20]),
    ];
  }

  BarChartGroupData _createBarGroup(int x, List<double> values) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: values[0],
          color: const Color(0xFFF97000),
          width: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: values[1],
          color: Colors.grey[600],
          width: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: values[2],
          color: Colors.grey[400],
          width: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildTotalBodyChart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Body Program Activity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 60,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 30,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: Colors.grey, fontSize: 12);
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = 'May';
                            break;
                          case 30:
                            text = 'Jun';
                            break;
                          case 60:
                            text = 'Jul';
                            break;
                          case 90:
                            text = 'Aug';
                            break;
                        }
                        return Text(text, style: style);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: List.generate(120, (index) {
                  double height;
                  if (index < 30) {
                    height = (index % 5 == 0) ? 40 : 20 + (index % 10) * 2;
                  } else if (index < 60) {
                    height = (index % 3 == 0) ? 50 : 30 + (index % 10) * 1.5;
                  } else if (index < 90) {
                    height = (index % 4 == 0) ? 45 : 25 + (index % 10) * 1;
                  } else {
                    height = (index % 6 == 0) ? 35 : 15 + (index % 10) * 1.2;
                  }
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: height,
                        color: const Color(0xFFF97000),
                        width: 2,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 65,
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
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected)
            Container(
              height: 2,
              width: 20,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF97000),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          Icon(
            icon,
            color: isSelected ? const Color(0xFFF97000) : Colors.grey,
            size: 24,
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
}