import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/theme_controller.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;

    return Scaffold(
      body: Obx(() => Container(
        decoration: BoxDecoration(
          gradient: themeController.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildAppBar(context, themeController),
                Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  padding: EdgeInsets.all(
                    isDesktop ? 80 : (isTablet ? 40 : 24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Me',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 56 : 40,
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Get to know me better',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: themeController.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 60),
                      _buildAboutCards(isDesktop, isTablet),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeController themeController) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: themeController.textPrimary,
            ),
            onPressed: () => Get.back(),
          ),
          const Spacer(),
          IconButton(
            icon: FaIcon(
              themeController.isDarkMode
                  ? FontAwesomeIcons.sun
                  : FontAwesomeIcons.moon,
              color: themeController.accentColor,
            ),
            onPressed: () => themeController.toggleTheme(),
          ),
        ],
      ),
    ));
  }

  Widget _buildAboutCards(bool isDesktop, bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isDesktop ? 2 : 1;
        double spacing = isDesktop ? 24 : 16;
        
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: isDesktop ? 1.5 : 1.2,
          children: const [
            _AboutCard(
              icon: FontAwesomeIcons.userTie,
              title: 'Who I Am',
              description:
                  'Passionate Flutter Developer creating dynamic mobile applications with Flutter, Firebase, and Dart.',
            ),
            _AboutCard(
              icon: FontAwesomeIcons.graduationCap,
              title: 'Education',
              description:
                  'BS Computer Science from Virtual University of Pakistan.',
            ),
            _AboutCard(
              icon: FontAwesomeIcons.briefcase,
              title: 'Experience',
              description:
                  'Currently at Covero Company. Previously at Propertier.com.pk.',
            ),
            _AboutCard(
              icon: FontAwesomeIcons.trophy,
              title: 'Achievements',
              description:
                  '8+ published apps on Play Store and App Store.',
            ),
          ],
        );
      },
    );
  }
}

class _AboutCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AboutCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<_AboutCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _isHovered
              ? themeController.hoverColor
              : themeController.cardColor,
          border: Border.all(
            color: _isHovered
                ? themeController.accentColor
                : themeController.borderColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              widget.icon,
              size: 36,
              color: themeController.accentColor,
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: themeController.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: themeController.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}