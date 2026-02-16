import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDarkMode = true.obs;
  final _selectedColorScheme = ColorSchemeType.cyanPurple.obs;
 
  bool get isDarkMode => _isDarkMode.value;
  ColorSchemeType get selectedColorScheme => _selectedColorScheme.value;
 
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeTheme(currentTheme);
  }
  
  void changeColorScheme(ColorSchemeType scheme) {
    _selectedColorScheme.value = scheme;
    Get.changeTheme(currentTheme);
  }
 
  ThemeData get currentTheme => _isDarkMode.value ? darkTheme : lightTheme;
 
  // Get current color scheme
  AppColorScheme get colorScheme {
    switch (_selectedColorScheme.value) {
      case ColorSchemeType.cyanPurple:
        return AppColorScheme.cyanPurple;
      case ColorSchemeType.modernBlue:
        return AppColorScheme.modernBlue;
      case ColorSchemeType.orangeBlue:
        return AppColorScheme.orangeBlue;
      case ColorSchemeType.greenTeal:
        return AppColorScheme.greenTeal;
      case ColorSchemeType.magentaPurple:
        return AppColorScheme.magentaPurple;
      case ColorSchemeType.sunsetOrange:
        return AppColorScheme.sunsetOrange;
      case ColorSchemeType.mintGreen:
        return AppColorScheme.mintGreen;
      case ColorSchemeType.royalGold:
        return AppColorScheme.royalGold;
    }
  }
  
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: const Color(0xFF0A0E27),
    cardColor: const Color(0xFF0F1229),
    colorScheme: ColorScheme.dark(
      primary: colorScheme.primary,
      secondary: colorScheme.secondary,
      tertiary: colorScheme.tertiary,
      surface: const Color(0xFF0F1229),
      background: const Color(0xFF0A0E27),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0A0E27),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
    ),
  );
 
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: colorScheme.primary,
      secondary: colorScheme.secondary,
      tertiary: colorScheme.tertiary,
      surface: Colors.white,
      background: const Color(0xFFF5F7FA),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
    ),
  );
 
  // Helper getters for commonly used colors
  Color get backgroundColor => _isDarkMode.value 
      ? const Color(0xFF0A0E27) 
      : const Color(0xFFF5F7FA);
      
  LinearGradient get backgroundGradient => _isDarkMode.value
      ? LinearGradient(
          colors: [const Color(0xFF0A0E27), const Color(0xFF1A1E3E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : LinearGradient(
          colors: [const Color(0xFFF5F7FA), const Color(0xFFE0E0E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  Color get cardColor => _isDarkMode.value 
      ? const Color(0xFF0F1229) 
      : Colors.white;
      
  Color get textPrimary => _isDarkMode.value 
      ? Colors.white 
      : const Color(0xFF1A1A1A);
      
  Color get textSecondary => _isDarkMode.value 
      ? const Color(0xFFB8B8D1) 
      : const Color(0xFF6B6B6B);
      
  Color get accentColor => colorScheme.primary;
  Color get secondaryAccent => colorScheme.secondary;
  Color get tertiaryAccent => colorScheme.tertiary;
  
  Color get borderColor => _isDarkMode.value 
      ? const Color(0xFF2A2E4E) 
      : const Color(0xFFE0E0E0);
      
  Color get hoverColor => _isDarkMode.value 
      ? const Color(0xFF1A1E3E) 
      : const Color(0xFFF0F2F5);
      
  // Gradient helpers for each color scheme
  LinearGradient get primaryGradient => LinearGradient(
    colors: [colorScheme.primary, colorScheme.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  LinearGradient get accentGradient => LinearGradient(
    colors: [colorScheme.secondary, colorScheme.tertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Enum for color scheme types
enum ColorSchemeType {
  cyanPurple,
  modernBlue,
  orangeBlue,
  greenTeal,
  magentaPurple,
  sunsetOrange,
  mintGreen,
  royalGold,
}

// Color scheme class
class AppColorScheme {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final String name;
  final String description;

  const AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.name,
    required this.description,
  });

  // Cyan Purple - Electric and Modern
  static const cyanPurple = AppColorScheme(
    primary: Color(0xFF00F5FF),
    secondary: Color(0xFF7B61FF),
    tertiary: Color(0xFF00D9FF),
    name: 'Cyan Purple',
    description: 'Electric and modern with vibrant cyan and purple',
  );

  // Modern Blue - Professional and Clean
  static const modernBlue = AppColorScheme(
    primary: Color(0xFF2563EB),
    secondary: Color(0xFF3B82F6),
    tertiary: Color(0xFF60A5FA),
    name: 'Modern Blue',
    description: 'Professional royal blue gradient',
  );

  // Orange Blue - Energetic Contrast
  static const orangeBlue = AppColorScheme(
    primary: Color(0xFFFF6B35),
    secondary: Color(0xFF004E89),
    tertiary: Color(0xFFFFA07A),
    name: 'Orange Blue',
    description: 'Energetic orange with deep blue contrast',
  );

  // Green Teal - Fresh and Natural
  static const greenTeal = AppColorScheme(
    primary: Color(0xFF10B981),
    secondary: Color(0xFF06B6D4),
    tertiary: Color(0xFF34D399),
    name: 'Green Teal',
    description: 'Fresh emerald green with cyan accents',
  );

  // Magenta Purple - Bold and Creative
  static const magentaPurple = AppColorScheme(
    primary: Color(0xFFEC4899),
    secondary: Color(0xFF8B5CF6),
    tertiary: Color(0xFFF472B6),
    name: 'Magenta Purple',
    description: 'Bold hot pink with violet highlights',
  );

  // Sunset Orange - Warm and Inviting
  static const sunsetOrange = AppColorScheme(
    primary: Color(0xFFFF6B6B),
    secondary: Color(0xFFFFA500),
    tertiary: Color(0xFFFFD93D),
    name: 'Sunset Orange',
    description: 'Warm sunset colors from red to golden',
  );

  // Mint Green - Calm and Soothing
  static const mintGreen = AppColorScheme(
    primary: Color(0xFF00C9A7),
    secondary: Color(0xFF84DCC6),
    tertiary: Color(0xFFA8E6CF),
    name: 'Mint Green',
    description: 'Calm mint green with soft pastels',
  );

  // Royal Gold - Luxury and Elegance
  static const royalGold = AppColorScheme(
    primary: Color(0xFFFFD700),
    secondary: Color(0xFF9333EA),
    tertiary: Color(0xFFFDB827),
    name: 'Royal Gold',
    description: 'Luxurious gold with royal purple',
  );

  // Get all available color schemes
  static List<AppColorScheme> get allSchemes => [
    cyanPurple,
    modernBlue,
    orangeBlue,
    greenTeal,
    magentaPurple,
    sunsetOrange,
    mintGreen,
    royalGold,
  ];
}