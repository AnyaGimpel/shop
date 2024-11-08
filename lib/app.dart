import 'package:flutter/material.dart';
import 'ui/screens/my_home_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop app',
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

      home: const MyHomePage(),
    );
  }
}