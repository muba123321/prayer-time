import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: const Color(0xFF772f30),
      items: const [
        CurvedNavigationBarItem(
            child: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: 'Search',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            label: 'Chat',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.newspaper,
              color: Colors.white,
            ),
            label: 'Feed',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.perm_identity,
              color: Colors.white,
            ),
            label: 'Personal',
            labelStyle: TextStyle(color: Colors.white)),
      ],
      onTap: (index) {
        // Handle button tap
      },
    );
  }
}
