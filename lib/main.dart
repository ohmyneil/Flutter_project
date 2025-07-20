import 'package:flutter/material.dart';
import 'home_page.dart'; // Import home page
import 'splash_screen.dart'; // Import SplashScreen
import 'login_screen.dart'; // Import LoginScreen
import 'signup_screen.dart'; // Import SignupScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A.C TRAVEL AND TOURS',
      theme: ThemeData(
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the initial route
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomePage(), // Added home route
      },
    );
  }
}