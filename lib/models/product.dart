class Product {
  int id;
  String title;
  double price;
  String image;
  String description;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    
    List<dynamic> images = json['images'] ?? [];  // Если нет поля 'images', используем пустой список
    String firstImage = images.isNotEmpty ? images[0] : '';  // Получаем первое изображение, если оно есть

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

