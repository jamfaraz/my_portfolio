
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';
import '../screens/home_screen.dart';
import 'primary_button.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Obx(() => Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : (isTablet ? 40 : 24)),
      child: Column(children: [
        ScrollReveal(
          direction: RevealDirection.fromRight,
          child: Text('Featured Projects',
            style: GoogleFonts.poppins(fontSize: isMobile ? 28 : 48, fontWeight: FontWeight.w700, color: tc.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 60),

        // Desktop: side-by-side with opposing directions
        if (isDesktop)
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: ScrollReveal(
                direction: RevealDirection.fromLeft,
                child: const _ProjectCard(
                  title: 'Covero Pro',
                  description: 'Professional service management application for Covero agents. Manage clients, appointments, and services efficiently.',
                  tags: ['Flutter', 'Firebase', 'GetX', 'REST API'],
                  icon: FontAwesomeIcons.briefcase,
                  gradient: LinearGradient(colors: [Color(0xFF00F5FF), Color(0xFF0099CC)]),
                ),
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: ScrollReveal(
                direction: RevealDirection.fromRight,
                delay: const Duration(milliseconds: 150),
                child: const _ProjectCard(
                  title: 'MyCovero',
                  description: 'Client portal for Covero services. Book appointments, track orders, and manage your account seamlessly.',
                  tags: ['Flutter', 'Firebase', 'Provider', 'Push Notifications'],
                  icon: FontAwesomeIcons.userGear,
                  gradient: LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)]),
                ),
              ),
            ),
          ])
        // Mobile/Tablet: stacked, alternating left/right
        else
          Column(children: [
            ScrollReveal(
              direction: RevealDirection.fromLeft,
              child: const _ProjectCard(
                title: 'Covero Pro',
                description: 'Professional service management application for Covero agents. Manage clients, appointments, and services efficiently.',
                tags: ['Flutter', 'Firebase', 'GetX', 'REST API'],
                icon: FontAwesomeIcons.briefcase,
                gradient: LinearGradient(colors: [Color(0xFF00F5FF), Color(0xFF0099CC)]),
              ),
            ),
            const SizedBox(height: 24),
            ScrollReveal(
              direction: RevealDirection.fromRight,
              delay: const Duration(milliseconds: 100),
              child: const _ProjectCard(
                title: 'MyCovero',
                description: 'Client portal for Covero services. Book appointments, track orders, and manage your account seamlessly.',
                tags: ['Flutter', 'Firebase', 'Provider', 'Push Notifications'],
                icon: FontAwesomeIcons.userGear,
                gradient: LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)]),
              ),
            ),
          ]),

        const SizedBox(height: 40),
        ScrollReveal(
          direction: RevealDirection.fromBottom,
          delay: const Duration(milliseconds: 200),
          child: PrimaryButton(text: 'View All Projects', icon: FontAwesomeIcons.arrowRight, onPressed: () => Get.toNamed('/projects')),
        ),
      ]),
    ));
  }
}

class _ProjectCard extends StatefulWidget {
  final String title; final String description;
  final List<String> tags; final IconData icon; final Gradient gradient;
  const _ProjectCard({required this.title, required this.description, required this.tags, required this.icon, required this.gradient});
  @override State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 1.02).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Obx(() => MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isMobile ? 340 : 380,
          decoration: BoxDecoration(
            color: tc.cardColor,
            border: Border.all(color: _hovered ? tc.accentColor : tc.borderColor, width: _hovered ? 2 : 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovered ? [BoxShadow(color: tc.accentColor.withOpacity(0.2), blurRadius: 20)] : [],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Center(child: FaIcon(widget.icon, size: 52, color: Colors.white)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: tc.textPrimary)),
                  const SizedBox(height: 10),
                  Text(widget.description, style: GoogleFonts.inter(fontSize: 13, color: tc.textSecondary, height: 1.5), maxLines: 3, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: widget.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tc.accentColor.withOpacity(0.1),
                        border: Border.all(color: tc.accentColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(tag, style: GoogleFonts.inter(fontSize: 11, color: tc.accentColor)),
                    )).toList(),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
