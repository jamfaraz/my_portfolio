import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDarkMode = true.obs;
  
  bool get isDarkMode => _isDarkMode.value;
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeTheme(_isDarkMode.value ? darkTheme : lightTheme);
  }
  
  ThemeData get currentTheme => _isDarkMode.value ? darkTheme : lightTheme;
  
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A0E27),
    scaffoldBackgroundColor: const Color(0xFF0A0E27),
    cardColor: const Color(0xFF0F1229),
  );
  
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    cardColor: Colors.white,
  );
  
  Color get backgroundColor => _isDarkMode.value ? const Color(0xFF0A0E27) : const Color(0xFFF5F7FA);
  Color get cardColor => _isDarkMode.value ? const Color(0xFF0F1229) : Colors.white;
  Color get textPrimary => _isDarkMode.value ? Colors.white : const Color(0xFF1A1A1A);
  Color get textSecondary => _isDarkMode.value ? const Color(0xFFB8B8D1) : const Color(0xFF6B6B6B);
  Color get accentColor => const Color(0xFF00F5FF);
  Color get secondaryAccent => const Color(0xFF7B61FF);
  Color get borderColor => _isDarkMode.value ? const Color(0xFF2A2E4E) : const Color(0xFFE0E0E0);
  Color get hoverColor => _isDarkMode.value ? const Color(0xFF1A1E3E) : const Color(0xFFF0F2F5);
}