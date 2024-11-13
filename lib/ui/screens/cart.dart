import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/ui/widgets/cart_item_card.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemCard(item: item); 
              },
            );
          }
        },
      ),
    );
  }
}
