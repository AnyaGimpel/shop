import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocs/product_cubit.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget{
  const ProductDetailPage({super.key});

  
  @override
  Widget build(BuildContext context){
    
    return BlocBuilder<ProductCubit, Product?>(
      builder: (context, product){
        if(product == null){
          return const Scaffold(
              body: Center(child: Text('No product selected')),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.image),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('\$${product.price}', style: const TextStyle(fontSize: 20, color: Colors.grey)),
                const SizedBox(height: 8),
                Text('Product ID: ${product.id}'),
              ],
            ),
          ),
        );


      },

    );
  }
}