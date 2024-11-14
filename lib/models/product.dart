/// Model class representing a product.
class Product {
  /// Unique identifier for the product.
  int id;

  /// Title or name of the product.
  String title;

  /// Price of the product.
  double price;

  /// URL for the main image of the product.
  String image;

  /// Description of the product.
  String description;

  /// Thumbnail URL for the product.
  String thumbnail;

/// Constructs a [Product] instance with required fields.
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.thumbnail,
  });

  /// Factory constructor to create a [Product] from a JSON object.
  ///
  /// Maps JSON fields to corresponding [Product] properties.
  factory Product.fromJson(Map<String, dynamic> json) {
    // Extracts the 'images' list from JSON and selects the first image if available.
    List<dynamic> images = json['images'] ?? [];  
    String firstImage = images.isNotEmpty ? images[0] : '';  

    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: firstImage,
      description: json['description'],
      thumbnail: json['thumbnail']
    );
  }
}

