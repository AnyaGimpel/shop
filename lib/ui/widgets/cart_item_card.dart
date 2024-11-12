import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/ui/widgets/quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
      padding: const EdgeInsets.all(12.0), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), 
            spreadRadius: 2, 
            blurRadius: 10, 
            offset: const Offset(0, 5), 
          ),
        ],
        //border: Border.all(color: Colors.grey.withOpacity(0.3)), // Рамка вокруг карточки
      ),
      child: ListTile(
        title: Text(
          'Product ID: ${item.productId}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuantitySelector(
              quantity: item.quantity,
              onIncrement: () {
                context.read<CartCubit>().incrementItem(item.productId);
              },
              onDecrement: () {
                context.read<CartCubit>().decrementItem(item.productId);
              },
              onRemoveItem: (){
                context.read<CartCubit>().removeItem(item.productId);
              },
            ),
          ],
        ),
      ),
    );
  }
}