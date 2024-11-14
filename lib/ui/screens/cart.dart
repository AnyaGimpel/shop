import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/ui/widgets/cart_item_card.dart';

/// Cart screen that displays a list of items in the user's cart.
class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            // Display a message if the cart is empty.
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            // Display a list of cart items.
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
