// lib/screens/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/theme_controller.dart';
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;

    // Calculate number of columns based on screen size
    int crossAxisCount = 1;
    if (isDesktop) {
      crossAxisCount = 3;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    // Calculate dynamic aspect ratio based on screen size and content
    double aspectRatio = _calculateAspectRatio(size.width, isDesktop, isTablet);

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
                    isDesktop ? 60 : (isTablet ? 40 : 24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'My Projects',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 56 : 40,
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Apps I\'ve built and published',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: themeController.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Stats
                      _buildStatsRow(themeController, isDesktop),
                      const SizedBox(height: 60),

                      // Projects Grid with automatic height calculation
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              childAspectRatio: aspectRatio,
                            ),
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              return ProjectCard(project: projects[index]);
                            },
                          );
                        },
                      ),
                      
                      // Add bottom padding for better scrolling experience
                      const SizedBox(height: 40),
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

  // Helper method to calculate dynamic aspect ratio
  double _calculateAspectRatio(double screenWidth, bool isDesktop, bool isTablet) {
    // Base aspect ratio for different screen sizes
    if (isDesktop) {
      // For desktop: wider cards
      return 0.9; // Height is 75% of width
    } else if (isTablet) {
      // For tablet: slightly taller cards
      return 0.84; // Height is 80% of width
    } else {
      // For mobile: taller cards to accommodate content
      return 1; // Height is 85% of width
    }
  }

  // Alternative method using LayoutBuilder for more precise control
 
  Widget _buildAppBar(BuildContext context, ThemeController themeController) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: themeController.textPrimary,
              size: 20,
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
              size: 20,
            ),
            onPressed: () => themeController.toggleTheme(),
          ),
        ],
      ),
    ));
  }

  Widget _buildStatsRow(ThemeController themeController, bool isDesktop) {
    return Row(
      children: [
        _buildStatCard('11+', 'Total Apps', themeController),
        Container(
          height: 40,
          width: 1,
          color: themeController.borderColor,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
        _buildStatCard('4', 'Play Store', themeController),
        Container(
          height: 40,
          width: 1,
          color: themeController.borderColor,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
        _buildStatCard('3', 'App Store', themeController),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, ThemeController themeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: themeController.accentColor,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: themeController.textSecondary,
          ),
        ),
      ],
    );
  }
}
  


// Project data model
class Project {
  final String title;
  final String description;
  final List<String> tags;
  final LinearGradient gradient;
  final IconData icon;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final bool isPublished;

  Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.gradient,
    required this.icon,
    this.playStoreUrl,
    this.appStoreUrl,
    this.isPublished = true,
  });
}

// All projects data from CV
final List<Project> projects = [
  // iOS Apps
  Project(
    title: 'Covero Pro',
    description: 'Professional service management application for Covero agents. Complete agent management system with real-time updates.',
    tags: ['Flutter', 'Firebase', 'GetX', 'iOS'],
    gradient: const LinearGradient(
      colors: [Color(0xFF00F5FF), Color(0xFF0099CC)],
    ),
    icon: FontAwesomeIcons.briefcase,
    appStoreUrl: 'https://apps.apple.com/pk/app/covero-pro/id6757465080',
  ),
  Project(
    title: 'MyCovero',
    description: 'Client portal for Covero services. Book appointments, track orders, and manage services seamlessly.',
    tags: ['Flutter', 'Firebase', 'iOS', 'Push Notifications'],
    gradient: const LinearGradient(
      colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)],
    ),
    icon: FontAwesomeIcons.userGear,
    appStoreUrl: 'https://apps.apple.com/pk/app/mycovero/id6757466997',
  ),
  Project(
    title: 'Pakistan Solar Market',
    description: 'Solar energy marketplace for Pakistan. Browse and purchase solar products with ease.',
    tags: ['Flutter', 'Firebase', 'Maps', 'iOS'],
    gradient: const LinearGradient(
      colors: [Color(0xFF6BCF7F), Color(0xFF55A666)],
    ),
    icon: FontAwesomeIcons.solarPanel,
    appStoreUrl: 'https://apps.apple.com/pk/app/psmapp/id6740829660',
  ),

  // Android Apps
  Project(
    title: 'Covero Client',
    description: 'Client-side application for Covero services. Easy booking and service management.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFFFF6B6B), Color(0xFFCC5555)],
    ),
    icon: FontAwesomeIcons.mobileScreen,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.covero.client',
  ),
  Project(
    title: 'Covero Agent',
    description: 'Agent management system for Covero platform. Handle clients and services efficiently.',
    tags: ['Flutter', 'REST API', 'Provider', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFFFFD93D), Color(0xFFCCAA30)],
    ),
    icon: FontAwesomeIcons.userTie,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.covero.agent',
  ),
  Project(
    title: 'Hoorain App',
    description: 'Shopping & Grocery delivery application. Order groceries and get them delivered.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFFB983FF), Color(0xFF9466CC)],
    ),
    icon: FontAwesomeIcons.cartShopping,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.hoorain.userapp',
  ),
  Project(
    title: 'Sea & Shore App',
    description: 'Cruise and sea experience application. Book and manage cruise adventures.',
    tags: ['Flutter', 'Firebase', 'Maps', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFF4ECDC4), Color(0xFF45B7D1)],
    ),
    icon: FontAwesomeIcons.ship,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cruiselegend.sea_and_shore',
  ),
  Project(
    title: 'Restaurant App',
    description: 'Restaurant management and ordering system for customers.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFFFFA07A), Color(0xFFFF7F50)],
    ),
    icon: FontAwesomeIcons.utensils,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yatriestrouser.app',
  ),
  Project(
    title: 'Restaurant Vendor',
    description: 'Vendor side application for restaurant management.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: const LinearGradient(
      colors: [Color(0xFF98D8C8), Color(0xFF5F9EA0)],
    ),
    icon: FontAwesomeIcons.store,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yatriestrouser.partner',
  ),

  // GitHub Projects
  Project(
    title: 'Quran App',
    description: 'Open source Quran application with translations and audio.',
    tags: ['Flutter', 'Dart', 'Open Source'],
    gradient: const LinearGradient(
      colors: [Color(0xFFCD5C5C), Color(0xFF8B4513)],
    ),
    icon: FontAwesomeIcons.bookQuran,
    playStoreUrl: 'https://github.com/jamfaraz/quran_app',
  ),
];


class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered ? (Matrix4.identity()..translate(0, -8)) : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            color: themeController.cardColor,
            border: Border.all(
              color: _isHovered
                  ? themeController.accentColor
                  : themeController.borderColor,
              width: _isHovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: themeController.accentColor.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: widget.project.gradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    // Pattern overlay
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: CustomPaint(
                          painter: PatternPainter(),
                        ),
                      ),
                    ),
                    // Icon
                    Center(
                      child: FaIcon(
                        widget.project.icon,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: themeController.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Description
                      Text(
                        widget.project.description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: themeController.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      
                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.tags
                            .map((tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: themeController.accentColor
                                        .withOpacity(0.1),
                                    border: Border.all(
                                      color: themeController.accentColor
                                          .withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tag,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: themeController.accentColor,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      
                      const Spacer(),
                      
                      // Store buttons
                      Row(
                        children: [
                          if (widget.project.playStoreUrl != null)
                            Expanded(
                              child: _StoreButton(
                                label: 'Play Store',
                                icon: FontAwesomeIcons.googlePlay,
                                url: widget.project.playStoreUrl!,
                                color: const Color(0xFF3DDC84),
                              ),
                            ),
                          if (widget.project.playStoreUrl != null &&
                              widget.project.appStoreUrl != null)
                            const SizedBox(width: 8),
                          if (widget.project.appStoreUrl != null)
                            Expanded(
                              child: _StoreButton(
                                label: 'App Store',
                                icon: FontAwesomeIcons.apple,
                                url: widget.project.appStoreUrl!,
                                color: const Color(0xFF0A84FF),
                              ),
                            ),
                          if (widget.project.playStoreUrl == null &&
                              widget.project.appStoreUrl == null &&
                              widget.project.tags.contains('Open Source'))
                            Expanded(
                              child: _StoreButton(
                                label: 'GitHub',
                                icon: FontAwesomeIcons.github,
                                url: widget.project.playStoreUrl ?? '',
                                color: const Color(0xFF333333),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _StoreButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color color;

  const _StoreButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.2)
                : widget.color.withOpacity(0.1),
            border: Border.all(
              color: _isHovered ? widget.color : widget.color.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                size: 11,
                color: widget.color,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: widget.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i + 10, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}