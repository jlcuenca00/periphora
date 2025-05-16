class Product {
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final List<String>? colors;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    this.colors,
  });
}
