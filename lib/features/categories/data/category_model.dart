class Category {
  final int id;
  final String name;
  final String imageUrl;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.productCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      productCount: json['productCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'productCount': productCount,
    };
  }
}
