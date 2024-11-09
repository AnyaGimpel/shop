import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ApiService {
  final String _baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async{
    final url = Uri.parse(_baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['products'];
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}