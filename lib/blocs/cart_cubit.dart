import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';
import '../services/cart_storage.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final CartStorage _storage;

  CartCubit(this._storage) : super([]){
    loadCart(); 
  } 

  Future<void> loadCart() async {
    final items = await _storage.loadCartItems();
    emit(items);  // Обновление состояния корзины
  }

  Future<void> incrementItem(int productId, String title, String thumbnail, double price) async {
    await _storage.addItem(productId, title, thumbnail, price, 1);
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

  Future<void> addItem(int productId, String title, String thumbnail, double price, int quantity) async {
    await _storage.addItem(productId, title, thumbnail, price, quantity);
    print('Товар с ID: $productId успешно добавлен в корзину с количеством $quantity');
    await loadCart();  // Перезагружаем корзину после добавления товара
  }

  int getProductQuantityInCart(int productId) {
    final item = state.firstWhere(
      (cartItem) => cartItem.productId == productId,
      orElse: () => CartItem(productId: productId, title: '', thumbnail: '', price: 0, quantity: 0),
    );
    return item.quantity;
  }

  bool isProductInCart(int productId) {
    return state.any((cartItem) => cartItem.productId == productId);
  }

  int getTotalQuantity() {
    return state.fold(0, (total, item) => total + item.quantity);
  }

}
