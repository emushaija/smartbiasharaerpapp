import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image with Opacity
        Positioned.fill(
          child: Opacity(
            opacity: 0.15, // Keep it faint
            child: Image.asset(
              'assets/images/accounting_bg.jpg', // Replace with your image
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stylish Dashboard Header
              Row(
                children: [
                  const Icon(Icons.bar_chart, color: Colors.white, size: 28),
                  const SizedBox(width: 10),
                  const Text(
                    'Dashboard Highlights',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                height: 3,
                width: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blueAccent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),

              // Responsive Grid Layout
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // 2 columns for balance
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildHighlightCard('Total Users', '1,250', Icons.people),
                    _buildHighlightCard('Pending Requests', '15', Icons.approval),
                    _buildHighlightCard('Revenue', '\$25,000', Icons.attach_money),
                    _buildHighlightCard('New Signups', '320', Icons.person_add),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Stylish Highlight Card
  Widget _buildHighlightCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with glow effect
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 10),

            // Value with premium text styling
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            // Title with better font styling
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
