import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';
import '../services/cart_storage.dart';

/// Cubit that manages the shopping cart state and interactions.
class CartCubit extends Cubit<List<CartItem>> {
  final CartStorage _storage;

  /// Constructor that initializes the CartCubit with the CartStorage and loads the initial cart items.
  CartCubit(this._storage) : super([]){
    loadCart(); 
  } 

  /// Loads the cart items from storage and updates the state.
  Future<void> loadCart() async {
    final items = await _storage.loadCartItems();
    emit(items);  
  }

  /// Increments the quantity of a product in the cart and updates the cart state.
  Future<void> incrementItem(int productId, String title, String thumbnail, double price) async {
    await _storage.addItem(productId, title, thumbnail, price, 1);
    await loadCart();  
  }

  /// Decrements the quantity of a product in the cart and updates the cart state.
  Future<void> decrementItem(int productId) async {
    await _storage.updateItemQuantity(productId, -1);
    await loadCart();  
  }

  /// Removes a product from the cart and updates the cart state.
  Future<void> removeItem(int productId) async {
    await _storage.removeItem(productId); 
    await loadCart();  
  }

  /// Adds a product to the cart and updates the cart state.
  Future<void> addItem(int productId, String title, String thumbnail, double price, int quantity) async {
    await _storage.addItem(productId, title, thumbnail, price, quantity);
    await loadCart();  
  }

  /// Gets the quantity of a specific product in the cart.
  int getProductQuantityInCart(int productId) {
    final item = state.firstWhere(
      (cartItem) => cartItem.productId == productId,
      orElse: () => CartItem(productId: productId, title: '', thumbnail: '', price: 0, quantity: 0),
    );
    return item.quantity;
  }

  /// Checks if a specific product is in the cart.
  bool isProductInCart(int productId) {
    return state.any((cartItem) => cartItem.productId == productId);
  }

  /// Gets the total quantity of all products in the cart.
  int getTotalQuantity() {
    return state.fold(0, (total, item) => total + item.quantity);
  }

}
