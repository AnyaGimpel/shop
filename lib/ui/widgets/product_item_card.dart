import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/product_cubit.dart';
import 'package:shop/blocs/cart_cubit.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/ui/screens/product_detail_page.dart';
import 'package:shop/ui/widgets/quantity_selector.dart'; // Добавим виджет QuantitySelector

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2 - 15;
    double imageHeight = cardWidth * 0.5;
    double textFontSize = cardWidth * 0.07;
    double buttonPadding = cardWidth * 0.1;
    double buttonHeight = cardWidth * 0.15;

    return GestureDetector(
      onTap: () {
        context.read<ProductCubit>().selectProduct(product);
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
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
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
              Expanded(
                child: BlocBuilder<CartCubit, List<CartItem>>(
                  builder: (context, cartState) {
                    // Проверяем, есть ли товар в корзине
                    bool isInCart = context.read<CartCubit>().isProductInCart(product.id);

                    if (isInCart) {
                      // Получаем количество товара в корзине
                      int quantity = context.read<CartCubit>().getProductQuantityInCart(product.id);

                      // Если товар в корзине, показываем QuantitySelector
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                        child: QuantitySelector(
                          quantity: quantity,
                          onIncrement: () {
                            context.read<CartCubit>().incrementItem(product.id, product.title, product.thumbnail, product.price);
                          },
                          onDecrement: () {
                            context.read<CartCubit>().decrementItem(product.id);
                          },
                          onRemoveItem: () {
                            context.read<CartCubit>().removeItem(product.id);
                          },

                          buttonSize: buttonHeight,  // Увеличиваем размер кнопок
                          textSize: buttonHeight / 2,
                        ),
                      );
                    } else {
                      // Если товара нет в корзине, показываем кнопку "Add to Cart"
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,  // Центрируем кнопку
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
