class AdminProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String imageKey;
  final bool showInHome;

  AdminProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.imageKey,
    required this.showInHome,
  });

  factory AdminProductModel.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return AdminProductModel(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      category: data['category'] ?? 'Serum',
      imageKey: data['imageKey'] ?? '',
      showInHome: data['showInHome'] ?? false,
    );
  }
}