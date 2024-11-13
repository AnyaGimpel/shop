import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/product_cubit.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop/ui/widgets/white_rounded_container.dart';
import 'package:shop/ui/widgets/quantity_selector.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenHeight * 0.4;
    double titleFontSize = screenWidth * 0.06;
    double descriptionFontSize = screenWidth * 0.045;
    double priceFontSize = screenWidth * 0.05;
    double avatarRadius = screenWidth * 0.06;
    double iconSize = screenWidth * 0.05;

    return BlocBuilder<ProductCubit, Product?>(
      builder: (context, product) {
        if (product == null) {
          return const Scaffold(
            body: Center(child: Text('No product selected')),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(
                        product.title,
                        style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                            fontSize: descriptionFontSize, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontSize: priceFontSize, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    width: screenWidth,
                    child: WhiteRoundedContainer(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: BlocBuilder<CartCubit, List<CartItem>>(
                          builder: (context, cartState) {
                            bool isInCart = context
                                .read<CartCubit>()
                                .isProductInCart(product.id);

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
                                    onIncrement: () {
                                      context.read<CartCubit>().incrementItem(
                                          product.id,
                                          product.title,
                                          product.thumbnail,
                                          product.price);
                                    },
                                    onDecrement: () {
                                      context
                                          .read<CartCubit>()
                                          .decrementItem(product.id);
                                    },
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
