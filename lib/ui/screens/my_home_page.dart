import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/ui/screens/cart.dart';
import 'package:shop/ui/screens/home.dart';
import 'package:shop/blocs/navigation_cubit.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

/// Main screen widget that displays either the Home or Cart screen based on the navigation state.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

/// List of screens to display: [Home] and [Cart].
  static const List<Widget> _screens = [
    Home(),
    Cart(),
  ];

/// Titles for each screen in the AppBar.
  static const List<String> _titles = [
    'Products',
    'Cart',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Display title based on the current screen index.
        title: Text(_titles[context.watch<NavigationCubit>().state]),
      ),
      // Display screen based on the navigation state.
      body: _screens[context.watch<NavigationCubit>().state],
      // Custom bottom navigation bar to switch between screens.
      bottomNavigationBar: const SafeArea(
        top: false, 
        child: CustomBottomNavigationBar(),
      ),
    );
  }
}
