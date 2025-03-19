import 'package:drift/drift.dart';

class CartItems extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text().nullable()();
  RealColumn get price => real()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id}; // Уникальность товара по ID
}
