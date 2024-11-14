import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/product_cubit.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop/ui/widgets/white_rounded_container.dart';
import 'package:shop/ui/widgets/quantity_selector.dart';

/// Screen that displays detailed information about a selected product.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // UI element size calculations
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenHeight * 0.4;
    double titleFontSize = screenWidth * 0.06;
    double descriptionFontSize = screenWidth * 0.045;
    double priceFontSize = screenWidth * 0.05;
    double avatarRadius = screenWidth * 0.06;
    double iconSize = screenWidth * 0.05;

    // Use BlocBuilder to display UI depending on the product state from ProductCubit.
    return BlocBuilder<ProductCubit, Product?>(
      builder: (context, product) {
        // If no product is selected
        if (product == null) {
          return const Scaffold(
            body: Center(child: Text('No product selected')),
          );
        }

        // Main UI layout
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Displays the main product image.
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: imageHeight,
                            maxWidth: double.infinity,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Displays the product title.
                      Text(
                        product.title,
                        style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Displays the product description.
                      Text(
                        product.description,
                        style: TextStyle(
                            fontSize: descriptionFontSize, color: Colors.black),
                      ),
                      const SizedBox(height: 8),

                      // Displays the product price.
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontSize: priceFontSize, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // Back button in the top left corner to navigate back.
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: avatarRadius,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        iconSize: iconSize,
                      ),
                    ),
                  ),
                ),

                // Bottom panel with "Add to Cart" button or quantity controls.
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    width: screenWidth,
                    child: WhiteRoundedContainer(
                      child: Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
                        
                        // Controls adding/removing product from cart.
                        child: BlocBuilder<CartCubit, List<CartItem>>(
                          builder: (context, cartState) {
                            // Check if the product is already in the cart.
                            bool isInCart = context
                                .read<CartCubit>()
                                .isProductInCart(product.id);
                            // If the product is in the cart, show quantity selector.
                            if (isInCart) {
                              int quantity = context
                                  .read<CartCubit>()
                                  .getProductQuantityInCart(product.id);

                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: screenWidth * 0.6,
                                  child: QuantitySelector(
                                    quantity: quantity,
                                    // Increment the product quantity in the cart.
                                    onIncrement: () {
                                      context.read<CartCubit>().incrementItem(
                                          product.id,
                                          product.title,
                                          product.thumbnail,
                                          product.price);
                                    },
                                    // Decrement the product quantity in the cart.
                                    onDecrement: () {
                                      context
                                          .read<CartCubit>()
                                          .decrementItem(product.id);
                                    },
                                    // Remove the product from the cart.
                                    onRemoveItem: () {
                                      context
                                          .read<CartCubit>()
                                          .removeItem(product.id);
                                    },
                                    buttonSize: 40.0,
                                    textSize: 20.0,
                                    spacing: 40.0,
                                  ),
                                ),
                              );
                            } else {
                              // If the product is not in the cart, show "Add to Cart" button.
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<CartCubit>().addItem(
                                        product.id,
                                        product.title,
                                        product.thumbnail,
                                        product.price,
                                        1,
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
