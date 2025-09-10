import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dashboard_widgets.dart';
import 'counselor_panel.dart';
import 'admin_panel.dart';

class WebDashboard extends StatefulWidget {
  const WebDashboard({super.key});

  @override
  State<WebDashboard> createState() => _WebDashboardState();
}

class _WebDashboardState extends State<WebDashboard> {
  int selectedIndex = 0;
  UserRole currentRole = UserRole.student;

  final List<DashboardTab> tabs = [
    DashboardTab(
      title: 'Overview',
      icon: Iconsax.home,
      role: UserRole.student,
    ),
    DashboardTab(
      title: 'Mental Health Tracker',
      icon: Iconsax.heart,
      role: UserRole.student,
    ),
    DashboardTab(
      title: 'Resources',
      icon: Iconsax.book,
      role: UserRole.student,
    ),
    DashboardTab(
      title: 'Community',
      icon: Iconsax.profile_2user,
      role: UserRole.student,
    ),
    DashboardTab(
      title: 'Appointments',
      icon: Iconsax.calendar_1,
      role: UserRole.student,
    ),
    DashboardTab(
      title: 'Counselor Panel',
      icon: Iconsax.health,
      role: UserRole.counselor,
    ),
    DashboardTab(
      title: 'Analytics',
      icon: Iconsax.chart,
      role: UserRole.admin,
    ),
  ];

  List<DashboardTab> get filteredTabs {
    return tabs.where((tab) => 
      tab.role == currentRole || 
      (currentRole == UserRole.admin && tab.role != UserRole.counselor) ||
      (currentRole == UserRole.counselor && tab.role == UserRole.student)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          if (isDesktop || isTablet)
            Container(
              width: isDesktop ? 280 : 240,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: _buildSidebar(),
            ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar
                _buildTopAppBar(screenWidth),
                
                // Content Area
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // Bottom Navigation for Mobile
      bottomNavigationBar: (!isDesktop && !isTablet) ? _buildBottomNav() : null,
      
      // Floating Action Button
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        // Logo Section
        Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MindCare',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Role Selector
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<UserRole>(
              value: currentRole,
              isExpanded: true,
              items: UserRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(
                    role.displayName,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (role) {
                if (role != null) {
                  setState(() {
                    currentRole = role;
                    selectedIndex = 0;
                  });
                }
              },
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Navigation Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: filteredTabs.length,
            itemBuilder: (context, index) {
              final tab = filteredTabs[index];
              final isSelected = selectedIndex == index;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  leading: Icon(
                    tab.icon,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
                  ),
                  title: Text(
                    tab.title,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[800],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              );
            },
          ),
        ),
        
        // User Profile Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentRole.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem(
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopAppBar(double screenWidth) {
    final isDesktop = screenWidth > 1200;
    
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle mobile menu
              },
            ),
          
          Text(
            filteredTabs[selectedIndex].title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const Spacer(),
          
          // Search
          if (isDesktop)
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          
          const SizedBox(width: 16),
          
          // Notifications
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Show notifications
            },
          ),
          
          // Emergency Button
          ElevatedButton.icon(
            onPressed: () {
              _showEmergencyDialog();
            },
            icon: const Icon(Icons.emergency, size: 16),
            label: const Text('Emergency'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              minimumSize: const Size(100, 36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (selectedIndex) {
      case 0:
        return const OverviewTab();
      case 1:
        return const MentalHealthTrackerTab();
      case 2:
        return const ResourcesTab();
      case 3:
        return const CommunityTab();
      case 4:
        return const AppointmentsTab();
      case 5:
        return const CounselorPanel();
      case 6:
        return const AdminAnalytics();
      default:
        return const OverviewTab();
    }
  }

  Widget? _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey[600],
      items: filteredTabs.take(4).map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(tab.icon),
          label: tab.title,
        );
      }).toList(),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (currentRole == UserRole.student && selectedIndex == 3) {
      return FloatingActionButton.extended(
        onPressed: () {
          // Create new post
        },
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      );
    } else if (currentRole == UserRole.counselor) {
      return FloatingActionButton.extended(
        onPressed: () {
          // Quick actions for counselor
        },
        icon: const Icon(Icons.add_circle),
        label: const Text('Quick Action'),
      );
    }
    return null;
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red[600]),
            const SizedBox(width: 8),
            const Text('Emergency Support'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('If you\'re in immediate danger or having thoughts of self-harm:'),
            SizedBox(height: 16),
            Text('• Call 911 (Emergency)'),
            Text('• National Suicide Prevention Lifeline: 988'),
            Text('• Crisis Text Line: Text HOME to 741741'),
            Text('• Campus Counseling: (555) 123-4567'),
            SizedBox(height: 16),
            Text('You are not alone. Help is available 24/7.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Direct to emergency services
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Call Now'),
          ),
        ],
      ),
    );
  }
}

enum UserRole {
  student,
  counselor,
  admin;

  String get displayName {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.counselor:
        return 'Counselor';
      case UserRole.admin:
        return 'Administrator';
    }
  }
}

class DashboardTab {
  final String title;
  final IconData icon;
  final UserRole role;

  DashboardTab({
    required this.title,
    required this.icon,
    required this.role,
  });
}
