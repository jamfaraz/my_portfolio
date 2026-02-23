// lib/screens/skills_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/theme_controller.dart';
import 'home_screen.dart'; // ScrollReveal, ScrollControllerProvider, RevealDirection

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final ScrollController _scrollCtrl = ScrollController();

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

    return Scaffold(
      body: Obx(() => Container(
        decoration: BoxDecoration(gradient: tc.backgroundGradient),
        child: ScrollControllerProvider(
          controller: _scrollCtrl,
          child: SingleChildScrollView(
            controller: _scrollCtrl,
            child: SafeArea(
              child: Column(
                children: [
                  // ── App Bar ──
                  _SkillsAppBar(isMobile: isMobile),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    padding: EdgeInsets.all(
                      isDesktop ? 80 : (isTablet ? 40 : 24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Page Title ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: _SkillsPageTitle(
                            isDesktop: isDesktop,
                            isTablet: isTablet,
                            isMobile: isMobile,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // ── Core Technologies ──
                        _AnimatedCategorySection(
                          title: 'Core Technologies',
                          skills: const [
                            _SkillData('Flutter', 95, FontAwesomeIcons.mobile),
                            _SkillData('Dart', 95, FontAwesomeIcons.code),
                            _SkillData('Firebase', 90, FontAwesomeIcons.fire),
                            _SkillData('REST APIs', 90, FontAwesomeIcons.cloudArrowUp),
                          ],
                          isDesktop: isDesktop,
                          isTablet: isTablet,
                          isMobile: isMobile,
                          sectionIndex: 0,
                        ),

                        const SizedBox(height: 40),

                        // ── State Management & Tools ──
                        _AnimatedCategorySection(
                          title: 'State Management & Tools',
                          skills: const [
                            _SkillData('GetX', 85, FontAwesomeIcons.gears),
                            _SkillData('Provider', 85, FontAwesomeIcons.boxesStacked),
                            _SkillData('Git & GitHub', 85, FontAwesomeIcons.github),
                            _SkillData('VS Code', 95, FontAwesomeIcons.code),
                          ],
                          isDesktop: isDesktop,
                          isTablet: isTablet,
                          isMobile: isMobile,
                          sectionIndex: 1,
                        ),

                        const SizedBox(height: 40),

                        // ── Development & Design ──
                        _AnimatedCategorySection(
                          title: 'Development & Design',
                          skills: const [
                            _SkillData('Android Studio', 90, FontAwesomeIcons.android),
                            _SkillData('Xcode', 85, FontAwesomeIcons.apple),
                            _SkillData('UI/UX Design', 80, FontAwesomeIcons.paintbrush),
                            _SkillData('Figma', 85, FontAwesomeIcons.figma),
                          ],
                          isDesktop: isDesktop,
                          isTablet: isTablet,
                          isMobile: isMobile,
                          sectionIndex: 2,
                        ),

                        const SizedBox(height: 40),

                        // ── Additional Skills ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: _AnimatedAdditionalSkills(isMobile: isMobile),
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
}

// ═══════════════════════════════════════════════════════════════
//  APP BAR
// ═══════════════════════════════════════════════════════════════

class _SkillsAppBar extends StatelessWidget {
  final bool isMobile;
  const _SkillsAppBar({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
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
            size: isMobile ? 18 : 20,
          ),
          onPressed: () => tc.toggleTheme(),
        ),
      ]),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  PAGE TITLE
// ═══════════════════════════════════════════════════════════════

class _SkillsPageTitle extends StatelessWidget {
  final bool isDesktop, isTablet, isMobile;
  const _SkillsPageTitle({
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 4, height: 52,
            decoration: BoxDecoration(color: tc.accentColor, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skills & Technologies',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 56 : (isTablet ? 40 : 32),
                  fontWeight: FontWeight.w700,
                  color: tc.textPrimary,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Technologies I work with',
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                  color: tc.textSecondary,
                ),
              ),
            ],
          ),
        ]),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  ANIMATED CATEGORY SECTION
// ═══════════════════════════════════════════════════════════════

class _AnimatedCategorySection extends StatelessWidget {
  final String title;
  final List<_SkillData> skills;
  final bool isDesktop, isTablet, isMobile;
  final int sectionIndex;

  const _AnimatedCategorySection({
    required this.title,
    required this.skills,
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final int cols = isDesktop ? 2 : (isTablet ? 2 : 1);
    final double aspectRatio = isDesktop ? 3.7 : (isTablet ? 2.5 : 3.8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with reveal
        ScrollReveal(
          direction: sectionIndex.isEven ? RevealDirection.fromLeft : RevealDirection.fromRight,
          child: _SectionHeader(title: title),
        ),
        const SizedBox(height: 20),

        // Skills Grid — each card revealed with staggered delay
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: isMobile ? 12 : 16,
            mainAxisSpacing: isMobile ? 12 : 16,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            // Alternate left/right reveals per column
            final direction = (index % cols == 0)
                ? RevealDirection.fromLeft
                : RevealDirection.fromRight;
            return ScrollReveal(
              direction: direction,
              delay: Duration(milliseconds: (index % cols) * 120 + sectionIndex * 60),
              child: _SkillCard(skill: skills[index], isMobile: isMobile),
            );
          },
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SECTION HEADER
// ═══════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: tc.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: Container(height: 1, color: tc.borderColor)),
        ]),
        const SizedBox(height: 8),
        Container(
          width: 60, height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tc.accentColor, tc.accentColor.withOpacity(0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  ADDITIONAL SKILLS (CHIPS)
// ═══════════════════════════════════════════════════════════════

class _AnimatedAdditionalSkills extends StatelessWidget {
  final bool isMobile;
  const _AnimatedAdditionalSkills({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final additionalSkills = [
      'Push Notifications',
      'Maps Integration',
      'Payment Gateways',
      'RESTful APIs',
      'Hive',
      'Shared Preferences',
      'Clean Architecture',
      'MVVM',
      'MVC',
    ];

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            'Additional Expertise',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 20 : 28,
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: Container(height: 1, color: tc.borderColor)),
        ]),
        const SizedBox(height: 8),
        Container(
          width: 60, height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tc.accentColor, tc.accentColor.withOpacity(0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          children: additionalSkills.asMap().entries.map((e) {
            return ScrollReveal(
              direction: RevealDirection.fromBottom,
              delay: Duration(milliseconds: e.key * 60),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: isMobile ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  color: tc.accentColor.withOpacity(0.1),
                  border: Border.all(color: tc.accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  e.value,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 12 : 14,
                    color: tc.accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  DATA MODEL
// ═══════════════════════════════════════════════════════════════

class _SkillData {
  final String name;
  final double level;
  final IconData icon;
  const _SkillData(this.name, this.level, this.icon);
}

// ═══════════════════════════════════════════════════════════════
//  SKILL CARD  (hover + animated progress bar — unchanged logic)
// ═══════════════════════════════════════════════════════════════

class _SkillCard extends StatefulWidget {
  final _SkillData skill;
  final bool isMobile;
  const _SkillCard({required this.skill, required this.isMobile});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bar;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _bar = Tween<double>(begin: 0, end: widget.skill.level / 100)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();

    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(widget.isMobile ? 12 : 20),
        decoration: BoxDecoration(
          color: _isHovered
              ? tc.accentColor.withOpacity(0.1)
              : tc.cardColor,
          border: Border.all(
            color: _isHovered ? tc.accentColor : tc.borderColor,
            width: _isHovered ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: tc.accentColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Container(
                padding: EdgeInsets.all(widget.isMobile ? 6 : 8),
                decoration: BoxDecoration(
                  color: tc.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FaIcon(widget.skill.icon,
                    color: tc.accentColor,
                    size: widget.isMobile ? 14 : 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(widget.skill.name,
                    style: GoogleFonts.inter(
                      fontSize: widget.isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: tc.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 8 : 10,
                    vertical: widget.isMobile ? 4 : 5),
                decoration: BoxDecoration(
                  color: tc.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${widget.skill.level.toInt()}%',
                    style: GoogleFonts.inter(
                      fontSize: widget.isMobile ? 12 : 14,
                      fontWeight: FontWeight.w700,
                      color: tc.accentColor,
                    )),
              ),
            ]),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _bar,
              builder: (context, _) => Stack(children: [
                Container(
                  height: widget.isMobile ? 6 : 8,
                  decoration: BoxDecoration(
                    color: tc.borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: _bar.value,
                  child: Container(
                    height: widget.isMobile ? 6 : 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        tc.accentColor,
                        tc.accentColor.withOpacity(0.7),
                      ]),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: tc.accentColor.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}