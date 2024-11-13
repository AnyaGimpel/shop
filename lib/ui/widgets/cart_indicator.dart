import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';

class CartIndicator extends StatelessWidget {
  const CartIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartItem>>(
      builder: (context, cartState) {
        // Получаем общее количество товаров в корзине
        int totalQuantity = context.read<CartCubit>().getTotalQuantity();

        return Positioned(
          top: -4,
          right: -4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              totalQuantity.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
