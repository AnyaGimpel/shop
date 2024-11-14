import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/ui/widgets/product_item_card.dart';
import 'package:shop/services/api_service.dart';
import 'package:get_it/get_it.dart';

/// Home screen that displays a grid of products.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Product>>(
            // Fetches the list of products from the ApiService.
            future: GetIt.instance<ApiService>().fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data.
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if the request fails.
                return const Center(child: Text('The page cannot load, check your internet connection'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Display a message if there are no products.
                return const Center(child: Text('No products found'));
              } else {
                // Display the list of products in a grid view.
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    // Display each product in a custom card widget.
                    return ProductItemCard(
                      product: snapshot.data![index],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
