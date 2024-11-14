import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/product_cubit.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/ui/screens/product_detail_page.dart';
import 'package:shop/ui/widgets/quantity_selector.dart'; 

/// A widget that displays a product item card in a grid or list format.
class ProductItemCard extends StatelessWidget {
  /// Product object to display its details on the card.
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Calculate the width and height of UI elements based on the screen size.
    double cardWidth = MediaQuery.of(context).size.width / 2 - 15;
    double imageHeight = cardWidth * 0.5;
    double textFontSize = cardWidth * 0.07;
    double buttonPadding = cardWidth * 0.1;
    double buttonHeight = cardWidth * 0.15;

    // Gesture detector to navigate to the product detail page when the card is tapped.
    return GestureDetector(
      onTap: () {
        // Set the selected product in the ProductCubit to be used on the details page.
        context.read<ProductCubit>().selectProduct(product);
        // Navigate to the product detail page.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailPage(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            // Shadow effect for the card container
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display the product image
              Padding(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: imageHeight,
                    maxWidth: double.infinity,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    // Show a loading indicator while the image loads.
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    // Show an error icon if the image fails to load.
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              // Display the title and price of the product.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: textFontSize,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Price: \$${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: textFontSize * 0.8,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                  ],
                ),
              ),

              // A section to manage the cart state: either show quantity controls or an "Add to Cart" button.
              Expanded(
                child: BlocBuilder<CartCubit, List<CartItem>>(
                  builder: (context, cartState) {
                    // Check if the product is already in the cart.
                    bool isInCart = context.read<CartCubit>().isProductInCart(product.id);

                    // If the product is already in the cart, show the quantity selector.
                    if (isInCart) {
                      int quantity = context.read<CartCubit>().getProductQuantityInCart(product.id);

                      // Display the quantity selector widget.
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                        child: QuantitySelector(
                          quantity: quantity,
                           // Callback for incrementing the item quantity in the cart.
                          onIncrement: () {
                            context.read<CartCubit>().incrementItem(product.id, product.title, product.thumbnail, product.price);
                          },
                          // Callback for decrementing the item quantity in the cart.
                          onDecrement: () {
                            context.read<CartCubit>().decrementItem(product.id);
                          },
                          // Callback for removing the item from the cart.
                          onRemoveItem: () {
                            context.read<CartCubit>().removeItem(product.id);
                          },

                          buttonSize: buttonHeight,  
                          textSize: buttonHeight / 2,
                        ),
                      );
                    } else {
                      // If the product is not in the cart, show the "Add to Cart" button.
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,  
                          children: [
                            ElevatedButton(
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
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(double.infinity, buttonHeight),
                              ),
                              child: Text(
                                'Add to cart',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
