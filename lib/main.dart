import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controllers/theme_controller.dart';
import 'screens/about_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/skils_screen.dart';

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
      theme: ThemeController.lightTheme,
      darkTheme: ThemeController.darkTheme,

      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/about', page: () => const AboutScreen()),
        GetPage(name: '/skills', page: () => const SkillsScreen()),
        GetPage(name: '/projects', page: () => const ProjectsScreen()),
        GetPage(name: '/contact', page: () => const ContactScreen()),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: themeController.backgroundGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(),
                const HeroSection(),
                const SizedBox(height: 80),
                const WhyChooseMeSection(),
                const SizedBox(height: 80),
                const FeaturedProjectsSection(),
                const SizedBox(height: 80),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24,
          vertical: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.code,
                  color: themeController.accentColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'MF',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: themeController.accentColor,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            if (isDesktop)
              Row(
                children: [
                  _NavItem(
                    icon: FontAwesomeIcons.user,
                    text: 'About',
                    onTap: () => Get.toNamed('/about'),
                  ),
                  const SizedBox(width: 40),
                  _NavItem(
                    icon: FontAwesomeIcons.code,
                    text: 'Skills',
                    onTap: () => Get.toNamed('/skills'),
                  ),
                  const SizedBox(width: 40),
                  _NavItem(
                    icon: FontAwesomeIcons.briefcase,
                    text: 'Projects',
                    onTap: () => Get.toNamed('/projects'),
                  ),
                  const SizedBox(width: 40),
                  _NavItem(
                    icon: FontAwesomeIcons.envelope,
                    text: 'Contact',
                    onTap: () => Get.toNamed('/contact'),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: FaIcon(
                      themeController.isDarkMode
                          ? FontAwesomeIcons.sun
                          : FontAwesomeIcons.moon,
                      color: themeController.accentColor,
                      size: 20,
                    ),
                    onPressed: () => themeController.toggleTheme(),
                  ),
                ],
              )
            else
              Row(
                children: [
                  IconButton(
                    icon: FaIcon(
                      themeController.isDarkMode
                          ? FontAwesomeIcons.sun
                          : FontAwesomeIcons.moon,
                      color: themeController.accentColor,
                      size: 20,
                    ),
                    onPressed: () => themeController.toggleTheme(),
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.bars,
                      color: themeController.textPrimary,
                      size: 20,
                    ),
                    onPressed: () => _showMobileMenu(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Obx(
        () => Container(
          decoration: BoxDecoration(
            color: themeController.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              _MobileMenuItem(
                icon: FontAwesomeIcons.user,
                text: 'About',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/about');
                },
              ),
              _MobileMenuItem(
                icon: FontAwesomeIcons.code,
                text: 'Skills',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/skills');
                },
              ),
              _MobileMenuItem(
                icon: FontAwesomeIcons.briefcase,
                text: 'Projects',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/projects');
                },
              ),
              _MobileMenuItem(
                icon: FontAwesomeIcons.envelope,
                text: 'Contact',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/contact');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.text, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Row(
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? themeController.accentColor
                    : themeController.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? themeController.accentColor
                      : themeController.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => ListTile(
        leading: FaIcon(icon, color: themeController.accentColor),
        title: Text(
          text,
          style: GoogleFonts.inter(
            color: themeController.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Hero Section
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 100 : (isTablet ? 60 : 40),
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _HeroContent()),
                const SizedBox(width: 60),
                const _HeroImage(),
              ],
            )
          : Column(
              children: [
                const _HeroImage(),
                const SizedBox(height: 40),
                _HeroContent(),
              ],
            ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Obx(
      () => Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: themeController.accentColor.withOpacity(0.1),
              border: Border.all(color: themeController.accentColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.mobileScreen,
                  size: 12,
                  color: themeController.accentColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'FLUTTER DEVELOPER',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: themeController.accentColor,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Muhammad\nFaraz',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 40 : 64,
              fontWeight: FontWeight.w700,
              color: themeController.textPrimary,
              height: 1.1,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 24),
          Text(
            'Crafting beautiful, dynamic mobile experiences\nwith Flutter & Firebase. Currently building\ninnovative solutions at Covero.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 18,
              color: themeController.textSecondary,
              height: 1.6,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              _PrimaryButton(
                text: 'View Projects',
                icon: FontAwesomeIcons.briefcase,
                onPressed: () => Get.toNamed('/projects'),
              ),
              _SecondaryButton(
                text: 'Contact Me',
                icon: FontAwesomeIcons.envelope,
                onPressed: () => Get.toNamed('/contact'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const _SocialLinks(),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => Container(
        width: isMobile ? 250 : 350,
        height: isMobile ? 250 : 350,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00F5FF), Color(0xFF7B61FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: themeController.accentColor.withOpacity(0.3),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeController.cardColor,
          ),
          child: ClipOval(
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.userTie,
                size: isMobile ? 100 : 140,
                color: themeController.accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Row(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: const [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/jamfaraz',
        ),
        SizedBox(width: 12),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          url: 'https://linkedin.com/in/muhammad-faraz1035bb297',
        ),
        SizedBox(width: 12),
        _SocialIcon(
          icon: FontAwesomeIcons.envelope,
          url: 'mailto:farazj105@gmail.com',
        ),
        SizedBox(width: 12),
        _SocialIcon(icon: FontAwesomeIcons.phone, url: 'tel:+923070217843'),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => _launchURL(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? themeController.accentColor.withOpacity(0.1)
                  : Colors.transparent,
              border: Border.all(
                color: _isHovered
                    ? themeController.accentColor
                    : themeController.borderColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              widget.icon,
              color: _isHovered
                  ? themeController.accentColor
                  : themeController.textPrimary,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// Why Choose Me Section
class WhyChooseMeSection extends StatelessWidget {
  const WhyChooseMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Obx(
      () => Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        ),
        child: Column(
          children: [
            Text(
              'Why Choose Me',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.w700,
                color: themeController.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Delivering excellence in mobile development',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: themeController.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
                double spacing = isDesktop ? 32 : 24;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: isMobile ? 1.2 : 1.0,
                  children: const [
                    _FeatureCard(
                      icon: FontAwesomeIcons.rocket,
                      title: '8+ Published Apps',
                      description:
                          'Successfully deployed apps on both Play Store and App Store',
                    ),
                    _FeatureCard(
                      icon: FontAwesomeIcons.code,
                      title: 'Clean Code',
                      description:
                          'Writing maintainable, scalable code following best practices',
                    ),
                    _FeatureCard(
                      icon: FontAwesomeIcons.bolt,
                      title: 'Fast Delivery',
                      description:
                          'Delivering high-quality projects within deadlines',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _isHovered
                ? themeController.hoverColor
                : themeController.cardColor,
            border: Border.all(
              color: _isHovered
                  ? themeController.accentColor
                  : themeController.borderColor,
              width: _isHovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: themeController.accentColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(widget.icon, size: 48, color: themeController.accentColor),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: themeController.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Featured Projects Section
class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Obx(
      () => Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        ),
        child: Column(
          children: [
            Text(
              'Featured Projects',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.w700,
                color: themeController.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = isDesktop ? 2 : 1;
                double spacing = isDesktop ? 32 : 24;
                double aspectRatio = isMobile ? 0.85 : 1.1;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                  children: const [
                    _ProjectCard(
                      title: 'Covero Pro',
                      description:
                          'Professional service management application for Covero agents. Manage clients, appointments, and services efficiently.',
                      tags: ['Flutter', 'Firebase', 'GetX', 'REST API'],
                      icon: FontAwesomeIcons.briefcase,
                      gradient: LinearGradient(
                        colors: [Color(0xFF00F5FF), Color(0xFF0099CC)],
                      ),
                    ),
                    _ProjectCard(
                      title: 'MyCovero',
                      description:
                          'Client portal for Covero services. Book appointments, track orders, and manage your account seamlessly.',
                      tags: [
                        'Flutter',
                        'Firebase',
                        'Provider',
                        'Push Notifications',
                      ],
                      icon: FontAwesomeIcons.userGear,
                      gradient: LinearGradient(
                        colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            _PrimaryButton(
              text: 'View All Projects',
              icon: FontAwesomeIcons.arrowRight,
              onPressed: () => Get.toNamed('/projects'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;
  final Gradient gradient;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.gradient,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: themeController.cardColor,
            border: Border.all(
              color: _isHovered
                  ? themeController.accentColor
                  : themeController.borderColor,
              width: _isHovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: themeController.accentColor.withOpacity(0.2),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: FaIcon(widget.icon, size: 56, color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: themeController.textSecondary,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.tags
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: themeController.accentColor
                                      .withOpacity(0.1),
                                  border: Border.all(
                                    color: themeController.accentColor
                                        .withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tag,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: themeController.accentColor,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Footer
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: themeController.borderColor)),
        ),
        child: Column(
          children: [
            Text(
              '© 2026 Muhammad Faraz. All rights reserved.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: themeController.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Built with Flutter',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: themeController.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                const FaIcon(
                  FontAwesomeIcons.heart,
                  size: 12,
                  color: Color(0xFFFF6B6B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Buttons
class _PrimaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [const Color(0xFF7B61FF), const Color(0xFF00F5FF)]
                  : [const Color(0xFF00F5FF), const Color(0xFF7B61FF)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              FaIcon(widget.icon, size: 14, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? themeController.accentColor.withOpacity(0.1)
                  : Colors.transparent,
              border: Border.all(
                color: _isHovered
                    ? themeController.accentColor
                    : themeController.borderColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isHovered
                        ? themeController.accentColor
                        : themeController.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                FaIcon(
                  widget.icon,
                  size: 14,
                  color: _isHovered
                      ? themeController.accentColor
                      : themeController.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
