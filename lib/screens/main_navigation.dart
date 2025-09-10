import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'home_screen.dart';
import 'chatbot_screen.dart';
import 'resources_screen.dart';
import 'peer_support_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatbotScreen(),
    const ResourcesScreen(),
    const PeerSupportScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home_1),
              activeIcon: Icon(Iconsax.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.message_question),
              activeIcon: Icon(Iconsax.messages_1),
              label: 'Chatbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book_1),
              activeIcon: Icon(Iconsax.book),
              label: 'Resources',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.people),
              activeIcon: Icon(Iconsax.profile_2user),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle),
              activeIcon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
