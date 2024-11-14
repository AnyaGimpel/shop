import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shop/models/cart_item.dart';

/// Handles storage and retrieval of cart items using SharedPreferences.
class CartStorage {
  /// Key used to store cart items in SharedPreferences
  static const String _cartKey = 'cart_items';

  /// Saves a list of cart items to SharedPreferences.
  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(items.map((item) => item.toMap()).toList());
    await prefs.setString(_cartKey, encodedData);
  }

  /// Loads the cart items from SharedPreferences.
  /// If no items are found, an empty list is returned.
  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      return decodedData.map((item) => CartItem.fromMap(item)).toList();
    }
    return [];
  }

  /// Adds a product to the cart or updates its quantity if it already exists in the cart.
  Future<void> addItem(int productId, String title, String thumbnail, double price, int quantity) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      // If the product is already in the cart, update its quantity
      items[index] = CartItem(
        productId: productId, 
        title: title,
        thumbnail: thumbnail,
        price: price,
        quantity: items[index].quantity + quantity,
      );
    } else {
      // If the product is not in the cart, add it as a new item
      items.add(CartItem(
        productId: productId,
        title: title,
        thumbnail: thumbnail,
        price: price,
        quantity: quantity,
      ));
    }
    await saveCartItems(items);
  }

  /// Removes a product from the cart.
  Future<void> removeItem(int productId) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      items.removeAt(index); 
      await saveCartItems(items);
    }
  }

  /// Updates the quantity of a specific product in the cart.
  Future<void> updateItemQuantity(int productId, int change) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      final newQuantity = items[index].quantity + change; // Update the product's quantity
      if (newQuantity > 0) {
        items[index] = CartItem(
          productId: items[index].productId,
          title: items[index].title,
          thumbnail: items[index].thumbnail,
          price: items[index].price, 
          quantity: newQuantity
        );
      } else {
        items.removeAt(index); // Remove the item from the cart if quantity becomes 0 or less
      }
      await saveCartItems(items);
    }
  }
}