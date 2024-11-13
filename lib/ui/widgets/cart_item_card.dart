import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/ui/widgets/quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double fullPrice = item.price * item.quantity;

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
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: item.thumbnail,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()), 
              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported), 
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total price: \$${fullPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: QuantitySelector(
                    quantity: item.quantity,
                    onIncrement: () {
                      context.read<CartCubit>().incrementItem(item.productId, item.title, item.thumbnail, item.price);
                    },
                    onDecrement: () {
                      context.read<CartCubit>().decrementItem(item.productId);
                    },
                    onRemoveItem: () {
                      context.read<CartCubit>().removeItem(item.productId);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
