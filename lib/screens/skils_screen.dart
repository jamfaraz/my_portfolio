import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/theme_controller.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Scaffold(
      body: Obx(() => Container(
        decoration: BoxDecoration(
          gradient: themeController.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildAppBar(context, themeController, isMobile),
                Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  padding: EdgeInsets.all(
                    isDesktop ? 80 : (isTablet ? 40 : 24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Skills & Technologies',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 56 : (isTablet ? 40 : 32),
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Technologies I work with',
                        style: GoogleFonts.inter(
                          fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                          color: themeController.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Skills Categories
                      _buildCategorySection(
                        'Core Technologies',
                        [
                          _SkillData('Flutter', 95, FontAwesomeIcons.mobile),
                          _SkillData('Dart', 95, FontAwesomeIcons.code),
                          _SkillData('Firebase', 90, FontAwesomeIcons.fire),
                          _SkillData('REST APIs', 90, FontAwesomeIcons.cloudArrowUp),
                        ],
                        themeController,
                        isDesktop,
                        isTablet,
                        isMobile,
                      ),
                      
                      const SizedBox(height: 40),
                      
                      _buildCategorySection(
                        'State Management & Tools',
                        [
                          _SkillData('GetX', 85, FontAwesomeIcons.gears),
                          _SkillData('Provider', 85, FontAwesomeIcons.boxesStacked),
                          _SkillData('Git & GitHub', 85, FontAwesomeIcons.github),
                          _SkillData('VS Code', 95, FontAwesomeIcons.code),
                        ],
                        themeController,
                        isDesktop,
                        isTablet,
                        isMobile,
                      ),
                      
                      const SizedBox(height: 40),
                      
                      _buildCategorySection(
                        'Development & Design',
                        [
                          _SkillData('Android Studio', 90, FontAwesomeIcons.android),
                          _SkillData('Xcode', 85, FontAwesomeIcons.apple),
                          _SkillData('UI/UX Design', 80, FontAwesomeIcons.paintbrush),
                          _SkillData('Figma', 85, FontAwesomeIcons.figma),
                        ],
                        themeController,
                        isDesktop,
                        isTablet,
                        isMobile,
                      ),

                      const SizedBox(height: 40),

                      // Additional Skills as Chips
                      _buildAdditionalSkills(themeController, isMobile),
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

  Widget _buildAppBar(BuildContext context, ThemeController themeController, bool isMobile) {
    return Obx(() => Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Row(
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: themeController.textPrimary,
              size: isMobile ? 18 : 20,
            ),
            onPressed: () => Get.back(),
          ),
          const Spacer(),
          // Language toggle
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Text(
              'Urdu / English',
              style: GoogleFonts.inter(
                fontSize: isMobile ? 12 : 14,
                color: themeController.textSecondary,
              ),
            ),
          ),
          IconButton(
            icon: FaIcon(
              themeController.isDarkMode
                  ? FontAwesomeIcons.sun
                  : FontAwesomeIcons.moon,
              color: themeController.accentColor,
              size: isMobile ? 18 : 20,
            ),
            onPressed: () => themeController.toggleTheme(),
          ),
        ],
      ),
    ));
  }

  Widget _buildCategorySection(
    String title,
    List<_SkillData> skills,
    ThemeController themeController,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
            fontWeight: FontWeight.w600,
            color: themeController.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [themeController.accentColor, themeController.accentColor.withOpacity(0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        
        // Skills Grid
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculate dynamic aspect ratio based on screen size
            double aspectRatio = _calculateAspectRatio(isDesktop, isTablet, isMobile);
            
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 2 : (isTablet ? 2 : 1),
                childAspectRatio: aspectRatio,
                crossAxisSpacing: isMobile ? 12 : 16,
                mainAxisSpacing: isMobile ? 12 : 16,
              ),
              itemCount: skills.length,
              itemBuilder: (context, index) => _SkillCard(
                skill: skills[index],
                isMobile: isMobile,
              ),
            );
          },
        ),
      ],
    );
  }

  double _calculateAspectRatio(bool isDesktop, bool isTablet, bool isMobile) {
    if (isDesktop) {
      return 3.7; // Wider cards for desktop
    } else if (isTablet) {
      return 2.5; // Slightly taller for tablet
    } else {
      return 3.8; // Taller for mobile
    }
  }

  Widget _buildAdditionalSkills(ThemeController themeController, bool isMobile) {
    final additionalSkills = [
      'Push Notifications',
      'Maps Integration',
      'Payment Gateways',
      'RESTful APIs',
      'GraphQL',
      'WebSockets',
      'SQLite',
      'Hive',
      'Shared Preferences',
      'Clean Architecture',
      'MVVM',
      'MVC',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Expertise',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w600,
            color: themeController.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [themeController.accentColor, themeController.accentColor.withOpacity(0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          children: additionalSkills.map((skill) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 6 : 8,
            ),
            decoration: BoxDecoration(
              color: themeController.accentColor.withOpacity(0.1),
              border: Border.all(
                color: themeController.accentColor.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              skill,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 12 : 14,
                color: themeController.accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class _SkillData {
  final String name;
  final double level;
  final IconData icon;

  const _SkillData(this.name, this.level, this.icon);
}

class _SkillCard extends StatefulWidget {
  final _SkillData skill;
  final bool isMobile;

  const _SkillCard({
    required this.skill,
    required this.isMobile,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.skill.level / 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(widget.isMobile ? 12 : 20),
        decoration: BoxDecoration(
          color: _isHovered
              ? themeController.accentColor.withOpacity(0.1)
              : themeController.cardColor,
          border: Border.all(
            color: _isHovered
                ? themeController.accentColor
                : themeController.borderColor,
            width: _isHovered ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: themeController.accentColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(widget.isMobile ? 6 : 8),
                  decoration: BoxDecoration(
                    color: themeController.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    widget.skill.icon,
                    color: themeController.accentColor,
                    size: widget.isMobile ? 14 : 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: GoogleFonts.inter(
                      fontSize: widget.isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: themeController.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 8 : 10,
                    vertical: widget.isMobile ? 4 : 5,
                  ),
                  decoration: BoxDecoration(
                    color: themeController.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.skill.level.toInt()}%',
                    style: GoogleFonts.inter(
                      fontSize: widget.isMobile ? 12 : 14,
                      fontWeight: FontWeight.w700,
                      color: themeController.accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  children: [
                    // Background bar
                    Container(
                      height: widget.isMobile ? 6 : 8,
                      decoration: BoxDecoration(
                        color: themeController.borderColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Animated progress bar
                    FractionallySizedBox(
                      widthFactor: _animation.value,
                      child: Container(
                        height: widget.isMobile ? 6 : 8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeController.accentColor,
                              themeController.accentColor.withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: themeController.accentColor.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}

