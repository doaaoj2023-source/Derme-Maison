class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;

  bool isFavorite;
  int cartQty;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    this.isFavorite = false,
    this.cartQty = 0,
  });
}