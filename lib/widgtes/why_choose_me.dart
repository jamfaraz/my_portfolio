
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';
import '../screens/home_screen.dart';

class WhyChooseMeSection extends StatelessWidget {
  const WhyChooseMeSection({super.key});

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
          direction: RevealDirection.fromLeft,
          child: Text('Why Choose Me',
            style: GoogleFonts.poppins(fontSize: isMobile ? 28 : 48, fontWeight: FontWeight.w700, color: tc.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        ScrollReveal(
          direction: RevealDirection.fromRight,
          delay: const Duration(milliseconds: 100),
          child: Text('Delivering excellence in mobile development',
            style: GoogleFonts.inter(fontSize: isMobile ? 14 : 16, color: tc.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 60),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
          mainAxisSpacing: isDesktop ? 32 : 24,
          crossAxisSpacing: isDesktop ? 32 : 24,
          childAspectRatio: isMobile ? 1.5 : 1.0,
          children: [
            ScrollReveal(
              direction: RevealDirection.fromBottom,
              delay: Duration.zero,
              child: const FeatureCard(icon: FontAwesomeIcons.rocket, title: '8+ Published Apps',
                  description: 'Successfully deployed apps on both Play Store and App Store'),
            ),
            ScrollReveal(
              direction: RevealDirection.fromBottom,
              delay: const Duration(milliseconds: 150),
              child: const FeatureCard(icon: FontAwesomeIcons.code, title: 'Clean Code',
                  description: 'Writing maintainable, scalable code following best practices'),
            ),
            ScrollReveal(
              direction: RevealDirection.fromBottom,
              delay: const Duration(milliseconds: 300),
              child: const FeatureCard(icon: FontAwesomeIcons.bolt, title: 'Fast Delivery',
                  description: 'Delivering high-quality projects within deadlines'),
            ),
          ],
        ),
      ]),
    ));
  }
}

class FeatureCard extends StatefulWidget {
  final IconData icon; final String title; final String description;
  const FeatureCard({required this.icon, required this.title, required this.description});
  @override State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _iconCtrl;
  late Animation<double> _iconRot;

  @override
  void initState() {
    super.initState();
    _iconCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _iconRot = Tween<double>(begin: 0, end: 0.06).animate(CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut));
  }
  @override void dispose() { _iconCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _iconCtrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _iconCtrl.reverse(); },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _hovered ? tc.hoverColor : tc.cardColor,
          border: Border.all(color: _hovered ? tc.accentColor : tc.borderColor, width: _hovered ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered ? [BoxShadow(color: tc.accentColor.withOpacity(0.2), blurRadius: 20, spreadRadius: 2)] : [],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RotationTransition(turns: _iconRot, child: FaIcon(widget.icon, size: 48, color: tc.accentColor)),
          const SizedBox(height: 20),
          Text(widget.title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: tc.textPrimary), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(widget.description, style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary, height: 1.6), textAlign: TextAlign.center),
        ]),
      ),
    ));
  }
}
