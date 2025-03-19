import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/features/cart/data/cart_provider.dart';
import 'package:test/features/cart/presentation/cart_card.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Корзина")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Корзина пуста"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(
                  item: item,
                  ref: ref,
                );
              },
            ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          ref.read(cartProvider.notifier).clearCart();
        },
        child: Text("Очистить корзину"),
      ),
    );
  }
}
