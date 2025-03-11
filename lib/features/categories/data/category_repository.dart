import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test/features/categories/data/category_model.dart';

class CategoryRepository {
  Future<List<Category>> loadCategories() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/categories.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      print('Ошибка при загрузке категорий: $e');
      rethrow;
    }
  }
}
