import 'package:flutter/material.dart';

class CartIndicator extends StatelessWidget {
  final String count; // Количество товаров в корзине

  const CartIndicator({super.key, this.count = '1'});


  @override
  Widget build(BuildContext context) {
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
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
