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
      appBar: AppBar(title: const Text('SmartBiashara ERP Dashboard')),

      // Sidebar Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => _navigateToPage(const DashboardPage()),
            ),
            ListTile(
              leading: const Icon(Icons.approval),
              title: const Text('Pending Requests'),
              onTap: () => _navigateToPage(const Center(child: Text('Pending Requests Page'))),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _navigateToPage(const Center(child: Text('Settings Page'))),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),

      // Middle Content Area (Changes dynamically)
      body: _selectedPage,

      // Footer (Optional)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.blueGrey[100],
        child: const Text(
          'SmartBiashara ERP © 2025',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }
}
