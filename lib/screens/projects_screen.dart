// lib/screens/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/theme_controller.dart';
import 'home_screen.dart';


enum StoreType { playStore, appStore, github }

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final LinearGradient gradient;
  final IconData icon;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.gradient,
    required this.icon,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
  });

  bool get hasPlayStore => playStoreUrl != null;
  bool get hasAppStore => appStoreUrl != null;
  bool get hasGitHub => githubUrl != null;
}

// ── Exact counts: 11 total, 6 Play Store, 4 App Store, 1 GitHub ──
final List<Project> projects = [
  // ── App Store (4) ──
  const Project(
    title: 'Covero Pro',
    description: 'Professional service management for Covero agents. Real-time updates, client management, and complete agent workflow.',
    tags: ['Flutter', 'Firebase', 'GetX', 'iOS'],
    gradient: LinearGradient(colors: [Color(0xFF00F5FF), Color(0xFF0099CC)]),
    icon: FontAwesomeIcons.briefcase,
    appStoreUrl: 'https://apps.apple.com/pk/app/covero-pro/id6757465080',
  ),
  const Project(
    title: 'MyCovero',
    description: 'Client portal for Covero services. Book appointments, track orders, and manage services seamlessly.',
    tags: ['Flutter', 'Firebase', 'iOS', 'Push Notifications'],
    gradient: LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)]),
    icon: FontAwesomeIcons.userGear,
    appStoreUrl: 'https://apps.apple.com/pk/app/mycovero/id6757466997',
  ),
  const Project(
    title: 'Pakistan Solar Market',
    description: 'Solar energy marketplace for Pakistan. Browse, compare, and purchase solar products with live pricing.',
    tags: ['Flutter', 'Firebase', 'Maps', 'iOS'],
    gradient: LinearGradient(colors: [Color(0xFF6BCF7F), Color(0xFF2ECC71)]),
    icon: FontAwesomeIcons.solarPanel,
    appStoreUrl: 'https://apps.apple.com/pk/app/psmapp/id6740829660',
  ),
  const Project(
    title: 'YatriRestro (iOS)',
    description: 'Restaurant ordering system for train travellers. Order food delivered to your seat.',
    tags: ['Flutter', 'Firebase', 'GetX', 'iOS'],
    gradient: LinearGradient(colors: [Color(0xFFFF9A56), Color(0xFFFF6348)]),
    icon: FontAwesomeIcons.utensils,
    appStoreUrl: 'https://apps.apple.com/pk/app/yatrirestro-food-in-train/id6744519330',
  ),

  // ── Play Store (6) ──
  const Project(
    title: 'Covero Client',
    description: 'Client-side application for Covero services. Easy booking, live tracking, and service management.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)]),
    icon: FontAwesomeIcons.mobileScreen,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.covero.client',
  ),
  const Project(
    title: 'Covero Agent',
    description: 'Agent management system for Covero platform. Handle clients, manage tasks, and track performance.',
    tags: ['Flutter', 'REST API', 'Provider', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFFFFD93D), Color(0xFFF9CA24)]),
    icon: FontAwesomeIcons.userTie,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.covero.agent',
  ),
  const Project(
    title: 'Hoorain App',
    description: 'On-demand grocery & shopping delivery. Browse thousands of products and get them delivered fast.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFFB983FF), Color(0xFF9B59B6)]),
    icon: FontAwesomeIcons.cartShopping,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.hoorain.userapp',
  ),
  const Project(
    title: 'Sea & Shore',
    description: 'Cruise and sea experience app. Discover, book, and manage cruise adventures worldwide.',
    tags: ['Flutter', 'Firebase', 'Maps', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFF4ECDC4), Color(0xFF1ABC9C)]),
    icon: FontAwesomeIcons.ship,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cruiselegend.sea_and_shore',
  ),
  const Project(
    title: 'YatriRestro User',
    description: 'Restaurant ordering app for customers. Browse menus, order food, and track delivery in real-time.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFFFFA07A), Color(0xFFE17055)]),
    icon: FontAwesomeIcons.bowlFood,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yatrirestrouser.app',
  ),
  const Project(
    title: 'YatriRestro Partner',
    description: 'Vendor management app for restaurant partners. Handle orders, manage menus, and track earnings.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Android'],
    gradient: LinearGradient(colors: [Color(0xFF81ECEC), Color(0xFF00B894)]),
    icon: FontAwesomeIcons.store,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yatrirestro.partner',
  ),

  // ── GitHub (1) ──
  const Project(
    title: 'Quran App',
    description: 'Open-source Quran application with translations, audio recitation, bookmarks, and prayer times.',
    tags: ['Flutter', 'Dart', 'Open Source'],
    gradient: LinearGradient(colors: [Color(0xFFCD5C5C), Color(0xFF8B4513)]),
    icon: FontAwesomeIcons.bookQuran,
    githubUrl: 'https://github.com/jamfaraz/quran_app',
  ),
];

// ═══════════════════════════════════════════════════════════════
//  PROJECTS SCREEN
// ═══════════════════════════════════════════════════════════════

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  // Exact counts derived from data
  int get _totalCount => projects.length; // 11
  int get _playStoreCount => projects.where((p) => p.hasPlayStore).length; // 6
  int get _appStoreCount => projects.where((p) => p.hasAppStore).length;  // 4
  int get _githubCount => projects.where((p) => p.hasGitHub).length;       // 1

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    final int columns = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double aspectRatio = isDesktop ? 0.82 : (isTablet ? 0.80 : 1.05);

    return Scaffold(
      body: Obx(() => Container(
        decoration: BoxDecoration(gradient: tc.backgroundGradient),
        child: ScrollControllerProvider(
          controller: _scrollCtrl,
          child: SingleChildScrollView(
            controller: _scrollCtrl,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── App Bar ──
                  _buildAppBar(tc),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 72 : (isTablet ? 40 : 24),
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // ── Page Title ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: tc.accentColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'My Projects',
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 36 : 56,
                                      fontWeight: FontWeight.w700,
                                      color: tc.textPrimary,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Apps shipped to production — real users, real impact.',
                                  style: GoogleFonts.inter(
                                    fontSize: isMobile ? 14 : 17,
                                    color: tc.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 48),

                        // ── Stats Row ──
                        ScrollReveal(
                          direction: RevealDirection.fromRight,
                          delay: const Duration(milliseconds: 100),
                          child: _StatsRow(
                            total: _totalCount,
                            playStore: _playStoreCount,
                            appStore: _appStoreCount,
                            github: _githubCount,
                            isMobile: isMobile,
                          ),
                        ),

                        const SizedBox(height: 56),

                        // ── Section Labels ──
                        _SectionDivider(label: 'App Store  •  $_appStoreCount apps', icon: FontAwesomeIcons.apple, color: const Color(0xFF0A84FF)),
                        const SizedBox(height: 24),

                        // App Store projects (first 4)
                        _buildGrid(
                          context,
                          projects.where((p) => p.hasAppStore).toList(),
                          columns: columns,
                          aspectRatio: aspectRatio,
                          baseDelay: 0,
                        ),

                        const SizedBox(height: 48),
                        _SectionDivider(label: 'Play Store  •  $_playStoreCount apps', icon: FontAwesomeIcons.googlePlay, color: const Color(0xFF00BF63)),
                        const SizedBox(height: 24),

                        // Play Store projects (6)
                        _buildGrid(
                          context,
                          projects.where((p) => p.hasPlayStore).toList(),
                          columns: columns,
                          aspectRatio: aspectRatio,
                          baseDelay: 100,
                        ),

                        const SizedBox(height: 48),
                        _SectionDivider(label: 'Open Source  •  $_githubCount repo', icon: FontAwesomeIcons.github, color: Colors.amber.shade600 ),
                        const SizedBox(height: 24),

                        // GitHub project
                        _buildGrid(
                          context,
                          projects.where((p) => p.hasGitHub).toList(),
                          columns: isMobile ? 1 : (isTablet ? 2 : 3),
                          aspectRatio: aspectRatio,
                          baseDelay: 0,
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    List<Project> list, {
    required int columns,
    required double aspectRatio,
    required int baseDelay,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: aspectRatio,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) => ScrollReveal(
        direction: index.isEven ? RevealDirection.fromLeft : RevealDirection.fromRight,
        delay: Duration(milliseconds: baseDelay + (index % columns) * 80),
        child: ProjectCard(project: list[index]),
      ),
    );
  }

  Widget _buildAppBar(ThemeController tc) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back button with label
          TextButton.icon(
            onPressed: () => Get.back(),
            icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 14, color: tc.accentColor),
            label: Text('Back', style: GoogleFonts.inter(color: tc.accentColor, fontWeight: FontWeight.w500)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: tc.accentColor.withOpacity(0.3)),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: FaIcon(
              tc.isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
              color: tc.accentColor,
              size: 18,
            ),
            onPressed: () => tc.toggleTheme(),
          ),
        ],
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  STATS ROW
// ═══════════════════════════════════════════════════════════════

class _StatsRow extends StatelessWidget {
  final int total, playStore, appStore, github;

  const _StatsRow({
    required this.total,
    required this.playStore,
    required this.appStore,
    required this.github,
    // isMobile param kept for API compatibility but ignored — we use LayoutBuilder
    bool isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();

    return Obx(() {
      final stats = [
        _StatData(value: '$total',     label: 'Total Apps',  icon: FontAwesomeIcons.mobileScreen, color: tc.accentColor),
        _StatData(value: '$playStore', label: 'Play Store',  icon: FontAwesomeIcons.googlePlay,   color: const Color(0xFF00BF63)),
        _StatData(value: '$appStore',  label: 'App Store',   icon: FontAwesomeIcons.apple,        color: const Color(0xFF0A84FF)),
        _StatData(value: '$github',    label: 'Open Source', icon: FontAwesomeIcons.github,        color: Colors.amber.shade600),
      ];

      return LayoutBuilder(builder: (context, constraints) {
        // Use actual available width — works inside GridView, Column, anywhere
        final compact = constraints.maxWidth < 500;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 32,
            vertical:   compact ? 14 : 28,
          ),
          decoration: BoxDecoration(
            color: tc.cardColor,
            border: Border.all(color: tc.borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: compact
              // ── Mobile: 2×2 grid ──
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Expanded(child: _StatItem(data: stats[0], compact: true)),
                      Container(width: 1, height: 50, color: tc.borderColor),
                      Expanded(child: _StatItem(data: stats[1], compact: true)),
                    ]),
                    Container(height: 1, color: tc.borderColor, margin: const EdgeInsets.symmetric(vertical: 10)),
                    Row(children: [
                      Expanded(child: _StatItem(data: stats[2], compact: true)),
                      Container(width: 1, height: 50, color: tc.borderColor),
                      Expanded(child: _StatItem(data: stats[3], compact: true)),
                    ]),
                  ],
                )
              // ── Desktop/Tablet: single row ──
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(data: stats[0], compact: false),
                    Container(width: 1, height: 56, color: tc.borderColor),
                    _StatItem(data: stats[1], compact: false),
                    Container(width: 1, height: 56, color: tc.borderColor),
                    _StatItem(data: stats[2], compact: false),
                    Container(width: 1, height: 56, color: tc.borderColor),
                    _StatItem(data: stats[3], compact: false),
                  ],
                ),
        );
      });
    });
  }
}

class _StatData {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  const _StatData({required this.value, required this.label, required this.icon, required this.color});
}

class _StatItem extends StatelessWidget {
  final _StatData data;
  final bool compact;

  const _StatItem({required this.data, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(data.icon, size: compact ? 14 : 18, color: data.color),
        SizedBox(height: compact ? 5 : 8),
        Text(
          data.value,
          style: GoogleFonts.poppins(
            fontSize: compact ? 24 : 32,
            fontWeight: FontWeight.w700,
            color: data.color,
            height: 1.0,
          ),
        ),
        SizedBox(height: compact ? 3 : 4),
        Text(
          data.label,
          style: GoogleFonts.inter(
            fontSize: compact ? 10 : 12,
            color: data.color.withOpacity(0.75),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SECTION DIVIDER
// ═══════════════════════════════════════════════════════════════

class _SectionDivider extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SectionDivider({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => ScrollReveal(
      direction: RevealDirection.fromLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              border: Border.all(color: color.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(icon, size: 13, color: color),
                const SizedBox(width: 8),
                Text(label,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Container(height: 1, color: tc.borderColor)),
        ],
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  PROJECT CARD
// ═══════════════════════════════════════════════════════════════

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _elevation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _scale = Tween<double>(begin: 1.0, end: 1.025)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _elevation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();

    return  MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedBuilder(
          animation: _elevation,
          builder: (_, __) => Container(
            decoration: BoxDecoration(
              color: tc.cardColor,
              border: Border.all(
                color: _hovered ? tc.accentColor : tc.borderColor,
                width: _hovered ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: tc.accentColor.withOpacity(0.15 * _elevation.value),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Gradient header ──
                _CardHeader(project: widget.project, hovered: _hovered),

                // ── Content ──
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.project.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: tc.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),

                        // Description
                        Text(
                          widget.project.description,
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: tc.textSecondary,
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),

                        // Tags
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: widget.project.tags.map((tag) => _Tag(tag: tag)).toList(),
                        ),

                        const Spacer(),

                        // Store buttons
                        _StoreButtons(project: widget.project),
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

class _CardHeader extends StatelessWidget {
  final Project project;
  final bool hovered;
  const _CardHeader({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 96,
      decoration: BoxDecoration(
        gradient: project.gradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Stack(
        children: [
          // Subtle diagonal lines pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: CustomPaint(painter: _DiagonalPattern()),
            ),
          ),
          // Store badges (top right)
          Positioned(
            top: 10,
            right: 12,
            child: Row(
              children: [
                if (project.hasAppStore)
                  _StoreBadge(icon: FontAwesomeIcons.apple, tooltip: 'App Store'),
                if (project.hasPlayStore)
                  _StoreBadge(icon: FontAwesomeIcons.googlePlay, tooltip: 'Play Store'),
                if (project.hasGitHub)
                  _StoreBadge(icon: FontAwesomeIcons.github, tooltip: 'GitHub'),
              ],
            ),
          ),
          // Centered icon
          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: hovered ? 1.15 : 1.0,
              child: FaIcon(project.icon, size: 36, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  const _StoreBadge({required this.icon, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: FaIcon(icon, size: 11, color: Colors.white),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String tag;
  const _Tag({required this.tag});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: tc.accentColor.withOpacity(0.08),
        border: Border.all(color: tc.accentColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        tag,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: tc.accentColor,
        ),
      ),
    ));
  }
}

class _StoreButtons extends StatelessWidget {
  final Project project;
  const _StoreButtons({required this.project});

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (project.hasAppStore) {
      buttons.add(Expanded(child: _StoreButton(
        label: 'App Store',
        icon: FontAwesomeIcons.apple,
        url: project.appStoreUrl!,
        color: const Color(0xFF0A84FF),
      )));
    }
    if (project.hasPlayStore) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 8));
      buttons.add(Expanded(child: _StoreButton(
        label: 'Play Store',
        icon: FontAwesomeIcons.googlePlay,
        url: project.playStoreUrl!,
        color: const Color(0xFF00BF63),
      )));
    }
    if (project.hasGitHub) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 8));
      buttons.add(Expanded(child: _StoreButton(
        label: 'View Code',
        icon: FontAwesomeIcons.github,
        url: project.githubUrl!,
        color: const Color(0xFFE8E8E8),
      )));
    }

    return Row(children: buttons);
  }
}

class _StoreButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color color;

  const _StoreButton({required this.label, required this.icon, required this.url, required this.color});
  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withOpacity(0.18) : widget.color.withOpacity(0.09),
            border: Border.all(color: _hovered ? widget.color : widget.color.withOpacity(0.28)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(widget.icon, size: 11, color: widget.color),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(fontSize: 10.5, fontWeight: FontWeight.w600, color: widget.color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  PAINTERS
// ═══════════════════════════════════════════════════════════════

class _DiagonalPattern extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (double i = -size.height; i < size.width + size.height; i += 18) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}