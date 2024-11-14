import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

/// Service class to handle API requests for getting products.
class ApiService {
  /// Base URL for product data.
  final String _baseUrl = 'https://dummyjson.com/products';

  /// Fetches a list of products from the API.
  ///
  /// Returns a [Future] containing a list of [Product] objects.
  /// Throws an exception if the request fails.
  Future<List<Product>> fetchProducts() async{
    final url = Uri.parse(_baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response and map it to a list of Product objects.
      List<dynamic> data = jsonDecode(response.body)['products'];
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      // Throw an exception if the status code is not 200.
      throw Exception('Failed to load products');
    }
  }

}