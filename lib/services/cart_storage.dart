import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shop/models/cart_item.dart';

class CartStorage {
  static const String _cartKey = 'cart_items';

  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(items.map((item) => item.toMap()).toList());
    await prefs.setString(_cartKey, encodedData);
  }

  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      return decodedData.map((item) => CartItem.fromMap(item)).toList();
    }
    return [];
  }

  Future<void> addItem(int productId, String title, String thumbnail, double price, int quantity) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      // Если товар уже есть в корзине, обновляем его количество
      items[index] = CartItem(
        productId: productId, 
        title: title,
        thumbnail: thumbnail,
        price: price,
        quantity: items[index].quantity + quantity,
      );
    } else {
      // Если товара нет в корзине, добавляем новый
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

  Future<void> removeItem(int productId) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      items.removeAt(index); // Удаление товара из корзины
      await saveCartItems(items);
    }
  }

  Future<void> updateItemQuantity(int productId, int change) async {
    final items = await loadCartItems();
    final index = items.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      final newQuantity = items[index].quantity + change;
      if (newQuantity > 0) {
        items[index] = CartItem(
          productId: items[index].productId,
          title: items[index].title,
          thumbnail: items[index].thumbnail,
          price: items[index].price, 
          quantity: newQuantity
        );
      } else {
        items.removeAt(index); // Удаление товара из корзины, если количество стало 0
      }
      await saveCartItems(items);
    }
  }
}