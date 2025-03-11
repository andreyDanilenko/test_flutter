import 'package:flutter/material.dart';
import 'package:test/features/products/data/product_model.dart';
import 'package:test/features/products/data/product_repository.dart';

class ProductsPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductsPage(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final data =
        await ProductRepository().loadProductsByCategory(widget.categoryId);
    setState(() {
      products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName), // Используем название категории
      ),
      body: ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('${product.price} ₽'),
            leading: _buildImage(product.imageUrl),
          );
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Image.asset(
      imageUrl,
      width: 50,
      height: 50,
      errorBuilder: (context, error, stackTrace) {
        // Заглушка, если картинка не найдена
        return const Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.grey,
        );
      },
    );
  }
}
