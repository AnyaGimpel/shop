import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/navigation_cubit.dart';
import 'cart_indicator.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(60, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                // При нажатии изменяем текущий индекс экрана
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
          if (showCartIndicator) const CartIndicator(count: '1'), // Индикатор корзины
        ],
      ),
      label: label,
    );
  }
}
