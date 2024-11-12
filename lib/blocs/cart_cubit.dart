import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';
import '../services/cart_storage.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final CartStorage _storage;

  CartCubit(this._storage) : super([]);  // Начальное состояние - пустой список

  Future<void> loadCart() async {
    final items = await _storage.loadCartItems();
    emit(items);  // Обновление состояния корзины
  }

  Future<void> incrementItem(int productId) async {
    await _storage.addItem(productId, 1);
    await loadCart();  // Перезагружаем корзину после обновления
  }

  Future<void> decrementItem(int productId) async {
    await _storage.updateItemQuantity(productId, -1);
    await loadCart();  // Перезагружаем корзину после обновления
  }

  Future<void> removeItem(int productId) async {
    await _storage.removeItem(productId); // Удаляем товар
    await loadCart();  
  }

  Future<void> addItem(int productId, int quantity) async {
    await _storage.addItem(productId, quantity);
    print('Товар с ID: $productId успешно добавлен в корзину с количеством $quantity');
    await loadCart();  // Перезагружаем корзину после добавления товара
  }
}
