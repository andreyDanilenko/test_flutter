import 'package:flutter/material.dart';
import 'package:test/features/categories/data/category_model.dart';
import 'package:test/features/categories/data/category_repository.dart';
import 'package:test/features/categories/presentation/category_card.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category>? categories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final data = await CategoryRepository().loadCategories();
    setState(() {
      categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (categories == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Категории"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          final category = categories![index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}
