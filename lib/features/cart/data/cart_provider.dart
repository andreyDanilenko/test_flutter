import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/core/db/database.dart'; // Import AppDatabase

// Define the database provider
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// Cart provider using the database provider
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) =>
      CartNotifier(ref.watch(databaseProvider)), // Pass AppDatabase instance
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  final AppDatabase db;

  CartNotifier(this.db) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = await db.getCartItems();
  }

  // Add item to cart
  Future<void> addToCart(CartItemsCompanion item) async {
    final existingItem = state.firstWhere(
      (cartItem) => cartItem.id == item.id.value,
      orElse: () => CartItem(id: 0, name: '', price: 0, quantity: 0),
    );

    if (existingItem.id != 0) {
      await db.updateQuantity(item.id.value, existingItem.quantity + 1);
    } else {
      await db.addToCart(item);
    }
    _loadCart();
  }

  // Remove item from cart
  Future<void> removeFromCart(int id) async {
    await db.removeFromCart(id);
    _loadCart();
  }

  // Clear the cart
  Future<void> clearCart() async {
    await db.clearCart();
    _loadCart();
  }

  // Update quantity of item in cart
  Future<void> updateCartItem(CartItemsCompanion item) async {
    await db.updateQuantity(item.id.value, item.quantity.value);
    _loadCart();
  }
}
