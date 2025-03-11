import 'package:flutter/material.dart';
import 'package:test/features/categories/presentation/categories_page.dart';
import 'package:test/features/home/presentation/home_page.dart';
import 'package:test/features/profile/presentation/profile_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String catalog = '/catalog';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(title: 'Главная'));
      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case catalog:
        return MaterialPageRoute(builder: (_) => CategoriesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Страница не найдена')),
          ),
        );
    }
  }
}
