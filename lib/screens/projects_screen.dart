import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.all(isMobile ? 20 : 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),
            Text(
              'My Projects',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 36 : 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Apps I\'ve built and published',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFFB8B8D1),
              ),
            ),
            const SizedBox(height: 60),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isMobile ? 0.9 : 1.0,
              children: const [
                ProjectCard(
                  title: 'Covero Pro',
                  description:
                      'Professional service management application for Covero agents. Manage clients, appointments, and services efficiently.',
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
                      'Client portal for Covero services. Book appointments, track orders, and manage your account seamlessly.',
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
                      'Client-side application for comprehensive Covero service management and bookings.',
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
                      'Agent management system for Covero platform. Handle service requests and client interactions.',
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
                      'Solar energy marketplace connecting buyers with solar panel providers across Pakistan.',
                  tags: ['Flutter', 'Firebase', 'Maps Integration'],
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
                      'Shopping & Grocery delivery application with real-time order tracking and multiple payment options.',
                  tags: ['Flutter', 'Firebase', 'GetX', 'Payment Gateway'],
                  gradient: LinearGradient(
                    colors: [Color(0xFFB983FF), Color(0xFF9466CC)],
                  ),
                  icon: FontAwesomeIcons.cartShopping,
                  playStoreUrl:
                      'https://play.google.com/store/apps/details?id=com.hoorain.userapp',
                ),
                ProjectCard(
                  title: 'Restaurant App (User)',
                  description:
                      'Full-featured restaurant ordering system for customers with menu browsing and order tracking.',
                  tags: ['Flutter', 'Firebase', 'Provider'],
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF9A8B), Color(0xFFCC7B6F)],
                  ),
                  icon: FontAwesomeIcons.utensils,
                  playStoreUrl:
                      'https://play.google.com/store/apps/details?id=com.yatrirestrouser.app',
                ),
                ProjectCard(
                  title: 'Restaurant App (Vendor)',
                  description:
                      'Vendor side of restaurant management system for order management and inventory tracking.',
                  tags: ['Flutter', 'Firebase', 'Admin Panel'],
                  gradient: LinearGradient(
                    colors: [Color(0xFF4FACFE), Color(0xFF3F8ACC)],
                  ),
                  icon: FontAwesomeIcons.store,
                  playStoreUrl:
                      'https://play.google.com/store/apps/details?id=com.yatrirestro.partner',
                ),
                ProjectCard(
                  title: 'Sea & Shore App',
                  description:
                      'Travel and tourism application for coastal destinations and marine activities.',
                  tags: ['Flutter', 'Maps', 'Booking System'],
                  gradient: LinearGradient(
                    colors: [Color(0xFF00D2FF), Color(0xFF0099CC)],
                  ),
                  icon: FontAwesomeIcons.ship,
                  playStoreUrl:
                      'https://play.google.com/store/apps/details?id=com.cruiselegend.sea_and_shore',
                ),
                ProjectCard(
                  title: 'Quran App',
                  description:
                      'Islamic Quran reading application with translations, audio recitations, and bookmarking features.',
                  tags: ['Flutter', 'Dart', 'Audio Player', 'UI/UX'],
                  gradient: LinearGradient(
                    colors: [Color(0xFF3DDC84), Color(0xFF30B069)],
                  ),
                  icon: FontAwesomeIcons.bookQuran,
                  githubUrl: 'https://github.com/jamfaraz/quran_app',
                ),
              ],
            ),
          ],
        ),
      ),
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
  final String? githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.gradient,
    required this.icon,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1229),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF00F5FF)
                : const Color(0xFF2A2E4E),
            width: _isHovered ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00F5FF).withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gradient Header
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
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFFB8B8D1),
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
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
                                color: const Color(0xFF00F5FF)
                                    .withOpacity(0.1),
                                border: Border.all(
                                  color: const Color(0xFF00F5FF)
                                      .withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF00F5FF),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Spacer(),
                    // Action Buttons
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
                        if (widget.githubUrl != null &&
                            widget.playStoreUrl == null &&
                            widget.appStoreUrl == null)
                          Expanded(
                            child: _ActionButton(
                              label: 'GitHub',
                              icon: FontAwesomeIcons.github,
                              url: widget.githubUrl!,
                              color: const Color(0xFFB8B8D1),
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
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                size: 14,
                color: widget.color,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
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