import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class NavigationBottomBar extends StatefulWidget {
  final TabController bottomBarController;

  const NavigationBottomBar({super.key, required this.bottomBarController});

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ConvexAppBar(
            controller: widget.bottomBarController,
            disableDefaultTabController: true,
            backgroundColor: Colors.white,
            style: TabStyle.fixed,
            color: Colors.grey,
            activeColor: Colors.teal,
            initialActiveIndex: _selectedIndex,
            shadowColor: Colors.teal,
            curveSize: 68,
            height: 65,
            top: -24.0,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 0) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (index == 2) {
                Navigator.pushReplacementNamed(context, '/recommendations');
              }
            },
            items: const [
              TabItem(
                activeIcon: Icon(Icons.home, color: Colors.teal),
                icon: Icon(Icons.home, color: Colors.grey),
                title: 'BMI Calculator',
              ),
              TabItem(
                icon: SizedBox(),
              ),
              TabItem(
                activeIcon: Icon(Icons.history, color: Colors.teal),
                icon: Icon(Icons.history, color: Colors.grey),
                title: 'Recommendations',
              ),
            ],
          ),
          Positioned.fill(
            top: -16,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.feedback, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add Feedback',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
