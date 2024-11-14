/// Model class representing a product item in the shopping cart.
class CartItem {
  /// Unique identifier for the product.
  final int productId;

  /// Title or name of the product.
  final String title;

  /// URL or path to the product's thumbnail image.
  final String thumbnail;

  /// Price of the product.
  final double price;

  /// Quantity of the product in the cart.
  final int quantity;
  
  /// Constructor to initialize the properties of CartItem.
  CartItem({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    
    
  });

  /// Converts the CartItem object to a Map for saving in SharedPreferences.
  /// 
  /// This method is useful for serializing the CartItem object into a format that can be 
  /// stored and later retrieved from storage.
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
    };
  }

  /// Converts a Map back into a CartItem object.
  /// 
  /// This factory constructor is useful for deserializing a Map (from SharedPreferences)
  /// back into a CartItem object.
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
