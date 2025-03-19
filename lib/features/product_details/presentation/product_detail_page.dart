import 'package:flutter/material.dart';
import 'package:test/core/db/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/features/products/data/product_model.dart';
import 'package:test/features/cart/data/cart_provider.dart';
import 'package:drift/drift.dart' as drift;

class ProductDetailPage extends ConsumerWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartItem = cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => const CartItem(id: 0, name: '', price: 0, quantity: 0),
    );

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(product.imageUrl),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              '${product.price} ₽',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            cartItem.id == 0
                ? ElevatedButton(
                    onPressed: () async {
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
                    child: const Text('Добавить в корзину'),
                  )
                : Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () async {
                          if (cartItem.quantity > 1) {
                            await cartNotifier.updateCartItem(
                              CartItemsCompanion(
                                id: drift.Value(cartItem.id),
                                name: drift.Value(cartItem.name),
                                price: drift.Value(cartItem.price),
                                quantity: drift.Value(cartItem.quantity - 1),
                              ),
                            );
                          } else {
                            await cartNotifier.removeFromCart(cartItem.id);
                          }
                        },
                      ),
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          await cartNotifier.updateCartItem(
                            CartItemsCompanion(
                              id: drift.Value(cartItem.id),
                              name: drift.Value(cartItem.name),
                              price: drift.Value(cartItem.price),
                              quantity: drift.Value(cartItem.quantity + 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            size: 250,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
