import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/navigation_cubit.dart';
import 'cart_indicator.dart';
import 'white_rounded_container.dart'; // Подключаем новый виджет

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return WhiteRoundedContainer(
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
