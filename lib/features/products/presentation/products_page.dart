import 'package:flutter/material.dart';
import 'package:test/features/products/data/product_model.dart';
import 'package:test/features/products/data/product_repository.dart';
import 'package:test/features/products/presentation/product_card.dart';

class ProductsPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductsPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

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
        title: Text(widget.categoryName),
      ),
      body: ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
