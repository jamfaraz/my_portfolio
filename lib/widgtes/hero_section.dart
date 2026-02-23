
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgtes/primary_button.dart';

import '../controllers/theme_controller.dart';
import 'social_section.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 100 : (isTablet ? 60 : 40),
      ),
      child: isDesktop
          ? Row(children: [Expanded(child: _HeroContent()), const SizedBox(width: 60), const _HeroImage()])
          : Column(children: [const _HeroImage(), const SizedBox(height: 32), _HeroContent()]),
    );
  }
}

// ── Typewriter name ──
class _AnimatedName extends StatefulWidget {
  final bool isMobile; final Color textColor; final Color accentColor;
  const _AnimatedName({required this.isMobile, required this.textColor, required this.accentColor});
  @override State<_AnimatedName> createState() => _AnimatedNameState();
}

class _AnimatedNameState extends State<_AnimatedName> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final String _full = 'Muhammad\nFaraz';
  String _shown = '';
  bool _cursor = true;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(milliseconds: _full.length * 80))..forward();
    _ctrl.addListener(() {
      final n = (_ctrl.value * _full.length).round().clamp(0, _full.length);
      if (mounted) setState(() => _shown = _full.substring(0, n));
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) setState(() => _cursor = !_cursor);
      return mounted;
    });
  }

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final done = _shown == _full;
    return RichText(
      textAlign: widget.isMobile ? TextAlign.center : TextAlign.left,
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: widget.isMobile ? 36 : 64, fontWeight: FontWeight.w700, color: widget.textColor, height: 1.1),
        children: [
          TextSpan(text: _shown),
          WidgetSpan(child: AnimatedOpacity(
            opacity: done ? (_cursor ? 1.0 : 0.0) : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: widget.isMobile ? 3 : 5,
              height: widget.isMobile ? 38 : 68,
              margin: const EdgeInsets.only(left: 3),
              decoration: BoxDecoration(color: widget.accentColor, borderRadius: BorderRadius.circular(2)),
            ),
          )),
        ],
      ),
    );
  }
}

// ── Hero content slides in from LEFT on page load ──
class _HeroContent extends StatefulWidget {
  @override State<_HeroContent> createState() => _HeroContentState();
}

class _HeroContentState extends State<_HeroContent> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(-0.15, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Obx(() => FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: tc.accentColor.withOpacity(0.1),
                border: Border.all(color: tc.accentColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                FaIcon(FontAwesomeIcons.mobileScreen, size: 12, color: tc.accentColor),
                const SizedBox(width: 8),
                Text('FLUTTER DEVELOPER', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: tc.accentColor, letterSpacing: 2)),
              ]),
            ),
            const SizedBox(height: 24),
            _AnimatedName(isMobile: isMobile, textColor: tc.textPrimary, accentColor: tc.accentColor),
            const SizedBox(height: 24),
            Text(
              'Crafting beautiful, dynamic mobile experiences\nwith Flutter & Firebase. Currently building\ninnovative solutions at Covero.',
              style: GoogleFonts.inter(fontSize: isMobile ? 13 : 18, color: tc.textSecondary, height: 1.6),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16, runSpacing: 16,
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: [
                PrimaryButton(text: 'View Projects', icon: FontAwesomeIcons.briefcase, onPressed: () => Get.toNamed('/projects')),
                SecondaryButton(text: 'Contact Me', icon: FontAwesomeIcons.envelope, onPressed: () => Get.toNamed('/contact')),
              ],
            ),
            const SizedBox(height: 32),
            const SocialLinks(),
          ],
        ),
      ),
    ));
  }
}

// ── Hero image slides in from RIGHT on page load + gentle pulse ──
class _HeroImage extends StatefulWidget {
  const _HeroImage();
  @override State<_HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<_HeroImage> with TickerProviderStateMixin {
  late AnimationController _entry, _pulse;
  late Animation<double> _entryFade;
  late Animation<Offset> _entrySlide;
  late Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..forward();
    _entryFade = CurvedAnimation(parent: _entry, curve: Curves.easeOut);
    _entrySlide = Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entry, curve: Curves.easeOutCubic));

    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _pulseScale = Tween<double>(begin: 0.96, end: 1.04).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override void dispose() { _entry.dispose(); _pulse.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;
    final size = isMobile ? w * 0.44 : (w < 900 ? 260.0 : 350.0);
    final tc = Get.find<ThemeController>();

    return Obx(() => FadeTransition(
      opacity: _entryFade,
      child: SlideTransition(
        position: _entrySlide,
        child: ScaleTransition(
          scale: _pulseScale,
          child: Container(
            width: size, height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF00F5FF), Color(0xFF7B61FF)],
              ),
              boxShadow: [BoxShadow(color: tc.accentColor.withOpacity(0.3), blurRadius: 40, spreadRadius: 5)],
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: tc.cardColor),
              child: ClipOval(child: Image.asset('assets/images/cv.png', fit: BoxFit.cover)),
            ),
          ),
        ),
      ),
    ));
  }
}

