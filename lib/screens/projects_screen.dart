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
                      const SizedBox(height: 60),
                      _buildProjectsGrid(isDesktop, isTablet),
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

  Widget _buildProjectsGrid(bool isDesktop, bool isTablet) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 2 : 1,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      childAspectRatio: isDesktop ? 1.0 : 0.9,
      children: const [
        ProjectCard(
          title: 'Covero Pro',
          description:
              'Professional service management application for Covero agents.',
          tags: ['Flutter', 'Firebase', 'GetX', 'REST API'],
          gradient: LinearGradient(
            colors: [Color(0xFF00F5FF), Color(0xFF0099CC)],
          ),
          icon: FontAwesomeIcons.briefcase,
          appStoreUrl:
              'https://apps.apple.com/pk/app/covero-pro/id6757465080',
        ),
        ProjectCard(
          title: 'MyCovero',
          description:
              'Client portal for Covero services. Book appointments and track orders.',
          tags: ['Flutter', 'Firebase', 'Provider', 'Push Notifications'],
          gradient: LinearGradient(
            colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)],
          ),
          icon: FontAwesomeIcons.userGear,
          appStoreUrl:
              'https://apps.apple.com/pk/app/mycovero/id6757466997',
        ),
        ProjectCard(
          title: 'Covero Client',
          description:
              'Client-side application for Covero services.',
          tags: ['Flutter', 'Firebase', 'GetX'],
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B6B), Color(0xFFCC5555)],
          ),
          icon: FontAwesomeIcons.mobileScreen,
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.covero.client',
        ),
        ProjectCard(
          title: 'Covero Agent',
          description:
              'Agent management system for Covero platform.',
          tags: ['Flutter', 'REST API', 'Provider'],
          gradient: LinearGradient(
            colors: [Color(0xFFFFD93D), Color(0xFFCCAA30)],
          ),
          icon: FontAwesomeIcons.userTie,
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.covero.agent',
        ),
        ProjectCard(
          title: 'Pakistan Solar Market',
          description:
              'Solar energy marketplace for Pakistan.',
          tags: ['Flutter', 'Firebase', 'Maps'],
          gradient: LinearGradient(
            colors: [Color(0xFF6BCF7F), Color(0xFF55A666)],
          ),
          icon: FontAwesomeIcons.solarPanel,
          appStoreUrl:
              'https://apps.apple.com/pk/app/psmapp/id6740829660',
        ),
        ProjectCard(
          title: 'Hoorain App',
          description:
              'Shopping & Grocery delivery application.',
          tags: ['Flutter', 'Firebase', 'GetX'],
          gradient: LinearGradient(
            colors: [Color(0xFFB983FF), Color(0xFF9466CC)],
          ),
          icon: FontAwesomeIcons.cartShopping,
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.hoorain.userapp',
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final Gradient gradient;
  final IconData icon;
  final String? playStoreUrl;
  final String? appStoreUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.gradient,
    required this.icon,
    this.playStoreUrl,
    this.appStoreUrl,
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
              height: 120,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: FaIcon(
                  widget.icon,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: themeController.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: themeController.textSecondary,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.tags
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: themeController.accentColor
                                      .withOpacity(0.1),
                                  border: Border.all(
                                    color: themeController.accentColor
                                        .withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  tag,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: themeController.accentColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (widget.playStoreUrl != null)
                          Expanded(
                            child: _ActionButton(
                              label: 'Play Store',
                              icon: FontAwesomeIcons.googlePlay,
                              url: widget.playStoreUrl!,
                              color: const Color(0xFF3DDC84),
                            ),
                          ),
                        if (widget.playStoreUrl != null &&
                            widget.appStoreUrl != null)
                          const SizedBox(width: 8),
                        if (widget.appStoreUrl != null)
                          Expanded(
                            child: _ActionButton(
                              label: 'App Store',
                              icon: FontAwesomeIcons.apple,
                              url: widget.appStoreUrl!,
                              color: const Color(0xFF0A84FF),
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
    ));
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color color;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.2)
                : widget.color.withOpacity(0.1),
            border: Border.all(
              color: _isHovered ? widget.color : widget.color.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                size: 12,
                color: widget.color,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
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