import 'package:flutter/material.dart';
import '../features/login/login_screen.dart';  // Corrected import path
import '../features/main/main_page.dart';
//import '../features/dashboard/dashboard_screen.dart'; // Corrected import path
//import '../features/home/payment_request_screen.dart'; // Corrected import path

class AppRoutes {
  static const String login = '/'; // Root route
  static const String dashboard = '/dashboard';
  static const String paymentRequests = '/paymentRequests';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

        case dashboard:
        return MaterialPageRoute(builder: (_) => MainPage());  // Navigate to dashboard
      default:
       
       return MaterialPageRoute(
        builder: (_) => Scaffold( // Or a dedicated "Not Found" screen widget
          body: Center(child: Text('Route not found: ${settings.name}')),
        ),
      );
    }
  }
}

