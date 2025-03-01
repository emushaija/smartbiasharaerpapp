import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../dashboard/dashboard_page.dart'; // Import Dashboard as the default page

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _selectedPage = const DashboardPage(); // Default page is Dashboard

  void _navigateToPage(Widget page) {
    setState(() {
      _selectedPage = page; // Change the content in the middle
    });
    Navigator.pop(context); // Close drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SmartBiashara ERP Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue,  // Blue AppBar
        elevation: 8,
        shadowColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality if needed
            },
          ),
        ],
      ),

      // Sidebar Navigation Drawer
      drawer: Drawer(
        elevation: 8,
        child: Container(
          color: Colors.white,  // White background for Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,  // Blue header background
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
                ),
                child: Text(
                  'SmartBiashara ERP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard, color: Colors.blue),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () => _navigateToPage(const DashboardPage()),
              ),
              ListTile(
                leading: const Icon(Icons.approval, color: Colors.blue),
                title: const Text(
                  'Pending Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () => _navigateToPage(const Center(child: Text('Pending Requests Page'))),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () => _navigateToPage(const Center(child: Text('Settings Page'))),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blue),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),

      // Middle Content Area (Changes dynamically)
      body: _selectedPage,

      // Footer (Optional)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        color: Colors.lightGreen[100],  // Light Green footer background
        child: const Text(
          '© 2025 SmartBiashara ERP. All Rights Reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
