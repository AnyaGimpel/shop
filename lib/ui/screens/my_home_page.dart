import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/ui/screens/cart.dart';
import 'package:shop/ui/screens/home.dart';
import 'package:shop/blocs/navigation_cubit.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const List<Widget> _screens = [
    Home(),
    Cart(),
  ];

  static const List<String> _titles = [
    'Products',
    'Cart',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[context.watch<NavigationCubit>().state]),
      ),
      body: _screens[context.watch<NavigationCubit>().state],
      bottomNavigationBar: const SafeArea(
        top: false, 
        child: CustomBottomNavigationBar(),
      ),
    );
  }
}
