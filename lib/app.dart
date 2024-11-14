import 'package:flutter/material.dart';
import 'ui/screens/my_home_page.dart';

/// The main application widget.
/// Sets up the `MaterialApp` with custom styling and the home page.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop app', // Application title.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.black, 
              fontSize: 24
          ),
          backgroundColor: Colors.white
        ),
      ),

      home: const MyHomePage(), // The main screen of the app.
    );
  }
}