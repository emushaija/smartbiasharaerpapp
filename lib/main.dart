import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'providers/payment_requests_provider.dart';
//import 'features/home/main_page.dart'; // Import your main page

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PaymentRequestsProvider(),
      child: const MyApp(),
    ),
  );
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
