import 'package:flutter/material.dart';
import 'package:test/core/db/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/features/cart/data/cart_provider.dart';
import 'package:test/features/products/data/product_model.dart';
import 'package:test/features/product_details/presentation/product_detail_page.dart';
import 'package:test/features/cart/presentation/cart_page.dart';
import 'package:drift/drift.dart' as drift;

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartItems = ref.watch(cartProvider);
    final isProductInCart = cartItems.any((item) => item.id == product.id);

    return GestureDetector(
        onTap: () {
          // Переход на страницу с деталями товара
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImage(product.imageUrl),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${product.price} ₽',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                isProductInCart
                    ? IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () async {
                          // Добавляем товар в корзину
                          await cartNotifier.addToCart(
                            CartItemsCompanion(
                              id: drift.Value(product.id),
                              name: drift.Value(product.name),
                              price: drift.Value(product.price),
                              quantity: const drift.Value(1),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('${product.name} добавлен в корзину')),
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
