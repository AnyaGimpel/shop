class CartItem {
  final int productId;
  final int quantity;
  

  CartItem({
    required this.productId,
    required this.quantity,
    
  });

  // Преобразование объекта CartItem в Map для сохранения в SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  // Преобразование Map обратно в объект CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }
}
