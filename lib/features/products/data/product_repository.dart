import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test/features/products/data/product_model.dart';

class ProductRepository {
  Future<List<Product>> loadProductsByCategory(int categoryId) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final categoryData = jsonList
          .firstWhere((category) => category['categoryId'] == categoryId);
      final List<dynamic> products = categoryData['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print('Ошибка при загрузке товаров: $e');
      rethrow;
    }
  }
}
