import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'screens/about_screen.dart';
import 'screens/home_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/skils_screen.dart';
import 'screens/theme_setting_scren.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: 'Muhammad Faraz - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/about', page: () => const AboutScreen()),
        GetPage(name: '/skills', page: () => const SkillsScreen()),
        GetPage(name: '/projects', page: () => const ProjectsScreen()),
        GetPage(name: '/contact', page: () => const ContactScreen()),
        GetPage(name: '/theme-settings', page: () => const ThemeSettingsScreen()),
      ],
    );
  }
}
