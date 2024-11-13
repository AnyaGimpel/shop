class CartItem {
  final int productId;
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;
  

  CartItem({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    
    
  });

  // Преобразование объекта CartItem в Map для сохранения в SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
    };
  }

  // Преобразование Map обратно в объект CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
    productId: map['productId'],
    title: map['title'],
    thumbnail: map['thumbnail'],
    price: (map['price'] ?? 0),
    quantity: map['quantity'],
  );
  }
}
