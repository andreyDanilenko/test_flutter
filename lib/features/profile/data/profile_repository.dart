import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test/features/profile/data/profile_model.dart';

class ProfileRepository {
  Future<Profile> loadProfile() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/profile.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Profile.fromJson(jsonMap);
    } catch (e) {
      print('Ошибка при загрузке профиля: $e');
      rethrow;
    }
  }
}
