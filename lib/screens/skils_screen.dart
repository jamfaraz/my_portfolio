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
                        'Skills & Technologies',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 56 : 40,
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Technologies I work with',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: themeController.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 60),
                      _buildSkillsGrid(isDesktop, isTablet),
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

  Widget _buildSkillsGrid(bool isDesktop, bool isTablet) {
    final skills = [
      _SkillData('Flutter', 95, FontAwesomeIcons.mobile),
      _SkillData('Dart', 95, FontAwesomeIcons.code),
      _SkillData('Firebase', 90, FontAwesomeIcons.fire),
      _SkillData('Provider', 85, FontAwesomeIcons.boxesStacked),
      _SkillData('GetX', 85, FontAwesomeIcons.gears),
      _SkillData('REST APIs', 90, FontAwesomeIcons.cloudArrowUp),
      _SkillData('VS Code', 95, FontAwesomeIcons.code),
      _SkillData('Android Studio', 90, FontAwesomeIcons.android),
      _SkillData('Git & GitHub', 85, FontAwesomeIcons.github),
      _SkillData('UI/UX Design', 80, FontAwesomeIcons.paintbrush),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 2 : 1,
        childAspectRatio: isDesktop ? 4 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) => _SkillCard(skill: skills[index]),
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

  const _SkillCard({required this.skill});

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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? themeController.hoverColor
              : themeController.cardColor,
          border: Border.all(
            color: _isHovered
                ? themeController.accentColor
                : themeController.borderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                FaIcon(
                  widget.skill.icon,
                  color: themeController.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: themeController.textPrimary,
                    ),
                  ),
                ),
                Text(
                  '${widget.skill.level.toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeController.accentColor,
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
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: themeController.borderColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: _animation.value,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00F5FF), Color(0xFF7B61FF)],
                          ),
                          borderRadius: BorderRadius.circular(4),
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