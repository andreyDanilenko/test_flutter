import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/features/cart/data/cart_provider.dart';
import 'package:test/core/db/database.dart';
import 'package:test/features/products/data/product_model.dart';
import 'package:test/features/product_details/presentation/product_detail_page.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final WidgetRef ref;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final product = Product(
          id: item.id,
          name: item.name,
          description: item.name,
          price: item.price,
          imageUrl: '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('${item.price} ₽'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (item.quantity > 1) {
                  ref.read(cartProvider.notifier).updateCartItem(
                        CartItemsCompanion(
                          id: Value(item.id),
                          name: Value(item.name),
                          price: Value(item.price),
                          quantity: Value(item.quantity - 1),
                        ),
                      );
                } else {
                  ref.read(cartProvider.notifier).removeFromCart(item.id);
                }
              },
            ),
            Text(item.quantity.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                ref.read(cartProvider.notifier).updateCartItem(
                      CartItemsCompanion(
                        id: Value(item.id),
                        name: Value(item.name),
                        price: Value(item.price),
                        quantity: Value(item.quantity + 1),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
