import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

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
              'Skills & Technologies',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 36 : 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Technologies I work with',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFFB8B8D1),
              ),
            ),
            const SizedBox(height: 60),
            // Core Technologies
            _SkillCategory(
              title: 'Core Technologies',
              icon: FontAwesomeIcons.code,
              skills: const [
                _SkillData('Flutter', 95, FontAwesomeIcons.mobile),
                _SkillData('Dart', 95, FontAwesomeIcons.code),
                _SkillData('Firebase', 90, FontAwesomeIcons.fire),
              ],
            ),
            const SizedBox(height: 40),
            // State Management
            _SkillCategory(
              title: 'State Management',
              icon: FontAwesomeIcons.diagramProject,
              skills: const [
                _SkillData('Provider', 85, FontAwesomeIcons.boxesStacked),
                _SkillData('GetX', 85, FontAwesomeIcons.gears),
                _SkillData('BLoC', 75, FontAwesomeIcons.cubes),
              ],
            ),
            const SizedBox(height: 40),
            // Backend & APIs
            _SkillCategory(
              title: 'Backend & APIs',
              icon: FontAwesomeIcons.server,
              skills: const [
                _SkillData('REST APIs', 90, FontAwesomeIcons.cloudArrowUp),
                _SkillData('GraphQL', 75, FontAwesomeIcons.sitemap),
                _SkillData('Node.js', 70, FontAwesomeIcons.nodeJs),
              ],
            ),
            const SizedBox(height: 40),
            // Development Tools
            _SkillCategory(
              title: 'Development Tools',
              icon: FontAwesomeIcons.toolbox,
              skills: const [
                _SkillData('VS Code', 95, FontAwesomeIcons.code),
                _SkillData(
                    'Android Studio', 90, FontAwesomeIcons.android),
                _SkillData('Git & GitHub', 85, FontAwesomeIcons.github),
                _SkillData('Postman', 80, FontAwesomeIcons.envelopeOpenText),
              ],
            ),
            const SizedBox(height: 40),
            // Design & UI
            _SkillCategory(
              title: 'Design & UI',
              icon: FontAwesomeIcons.paintbrush,
              skills: const [
                _SkillData('Material Design', 90, FontAwesomeIcons.palette),
                _SkillData('Responsive Design', 90, FontAwesomeIcons.mobile),
                _SkillData('Figma', 75, FontAwesomeIcons.figma),
              ],
            ),
            const SizedBox(height: 40),
            // Other Skills
            _SkillCategory(
              title: 'Other Skills',
              icon: FontAwesomeIcons.star,
              skills: const [
                _SkillData('Debugging', 90, FontAwesomeIcons.bug),
                _SkillData('Performance Optimization', 85,
                    FontAwesomeIcons.gaugeHigh),
                _SkillData('Testing', 80, FontAwesomeIcons.clipboardCheck),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillData {
  final String name;
  final double level;
  final IconData icon;

  const _SkillData(this.name, this.level, this.icon);
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_SkillData> skills;

  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              color: const Color(0xFF00F5FF),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            childAspectRatio: isMobile ? 3 : 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return _SkillCard(skill: skills[index]);
          },
        ),
      ],
    );
  }
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF1A1E3E)
              : const Color(0xFF0F1229),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF00F5FF)
                : const Color(0xFF2A2E4E),
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
                  color: const Color(0xFF00F5FF),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  '${widget.skill.level.toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00F5FF),
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
                        color: const Color(0xFF2A2E4E),
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
    );
  }
}