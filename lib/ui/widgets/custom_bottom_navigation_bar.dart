import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/navigation_cubit.dart';
import 'cart_indicator.dart';
import 'white_rounded_container.dart';

/// Custom bottom navigation bar widget with navigation and cart indicator.
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return SizedBox(
          height: 60, 
          child: WhiteRoundedContainer(
            child: BottomNavigationBar(
              // Set the selected index based on the current state
              currentIndex: selectedIndex, 
              onTap: (index) {
                // Update the selected index in the state
                context.read<NavigationCubit>().setScreen(index);
              },
              items: [
                _buildNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                ),
                _buildNavigationBarItem(
                  icon: Icons.shopping_cart,
                  label: 'Cart',
                  // Shows the cart indicator 
                  showCartIndicator: true,
                ),
              ],
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        );
      },
    );
  }

  /// Helper function to create a navigation bar item with an optional cart indicator.
  BottomNavigationBarItem _buildNavigationBarItem({
    required IconData icon,
    required String label,
    bool showCartIndicator = false,
  }) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon),
          if (showCartIndicator) const CartIndicator(),
        ],
      ),
      label: label,
    );
  }
}
