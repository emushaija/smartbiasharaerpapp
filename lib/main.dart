import 'package:flutter/material.dart';
import 'features/login/login_screen.dart';
import 'routes/app_routes.dart';
//import 'features/home/main_page.dart'; // Import your main page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'SmartBiashara ERP | Relax !',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    

      initialRoute: AppRoutes.login, // Set the initial route to login
      onGenerateRoute: AppRoutes.generateRoute, 
      // home: LoginScreen(),
    
    );
  
  }
  
}
