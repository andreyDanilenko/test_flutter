import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/features/cart/data/cart_item.dart';

part 'database.g.dart';

@DriftDatabase(tables: [CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<CartItem>> getCartItems() => select(cartItems).get();
  Future<void> addToCart(CartItemsCompanion item) =>
      into(cartItems).insert(item, mode: InsertMode.insertOrReplace);

  Future<void> updateQuantity(int id, int quantity) async {
    await (update(cartItems)..where((t) => t.id.equals(id)))
        .write(CartItemsCompanion(quantity: Value(quantity)));
  }

  Future<void> removeFromCart(int id) =>
      (delete(cartItems)..where((t) => t.id.equals(id))).go();

  Future<void> clearCart() => delete(cartItems).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cart.sqlite'));
    return NativeDatabase(file);
  });
}
// flutter pub get
// flutter packages pub run build_runner build
// dependencies:
//   flutter:
//     sdk: flutter
//   drift: ^2.5.0 
//   drift_dev: ^2.5.0 
//   path_provider: ^2.0.3 
//   path: ^1.8.0  

// dev_dependencies:
//   flutter_test:
//     sdk: flutter
//   build_runner: ^2.1.4  
//   drift_dev: ^2.5.0
