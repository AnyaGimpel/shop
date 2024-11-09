class Product {
  int id;
  String title;
  double price;
  String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    
    List<dynamic> images = json['images'] ?? [];  // Если нет поля 'images', используем пустой список
    String firstImage = images.isNotEmpty ? images[0] : '';  // Получаем первое изображение, если оно есть

    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: firstImage,
    );
  }
}

