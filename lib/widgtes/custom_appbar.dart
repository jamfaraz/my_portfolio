
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedLogo(accentColor: tc.accentColor),
          if (isDesktop)
            Row(children: [
              NavItem(icon: FontAwesomeIcons.user, text: 'About', onTap: () => Get.toNamed('/about')),
              const SizedBox(width: 40),
              NavItem(icon: FontAwesomeIcons.code, text: 'Skills', onTap: () => Get.toNamed('/skills')),
              const SizedBox(width: 40),
              NavItem(icon: FontAwesomeIcons.briefcase, text: 'Projects', onTap: () => Get.toNamed('/projects')),
              const SizedBox(width: 40),
              NavItem(icon: FontAwesomeIcons.envelope, text: 'Contact', onTap: () => Get.toNamed('/contact')),
              const SizedBox(width: 40),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.palette, color: tc.accentColor, size: 20),
                onPressed: () => Get.toNamed('/theme-settings'),
                tooltip: 'Theme Settings',
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: FaIcon(tc.isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                    color: tc.accentColor, size: 20),
                onPressed: () => tc.toggleTheme(),
              ),
            ])
          else
            Row(children: [
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.palette, color: tc.accentColor, size: 20),
                  onPressed: () => Get.toNamed('/theme-settings')),
              IconButton(
                  icon: FaIcon(tc.isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                      color: tc.accentColor, size: 20),
                  onPressed: () => tc.toggleTheme()),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.bars, color: tc.textPrimary, size: 20),
                  onPressed: () => _showMobileMenu(context)),
            ]),
        ],
      ),
    ));
  }

  void _showMobileMenu(BuildContext context) {
    final tc = Get.find<ThemeController>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Obx(() => Container(
        decoration: BoxDecoration(
          color: tc.cardColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 20),
          MobileMenuItem(icon: FontAwesomeIcons.user, text: 'About', onTap: () { Navigator.pop(ctx); Get.toNamed('/about'); }),
          MobileMenuItem(icon: FontAwesomeIcons.code, text: 'Skills', onTap: () { Navigator.pop(ctx); Get.toNamed('/skills'); }),
          MobileMenuItem(icon: FontAwesomeIcons.briefcase, text: 'Projects', onTap: () { Navigator.pop(ctx); Get.toNamed('/projects'); }),
          MobileMenuItem(icon: FontAwesomeIcons.envelope, text: 'Contact', onTap: () { Navigator.pop(ctx); Get.toNamed('/contact'); }),
          MobileMenuItem(icon: FontAwesomeIcons.palette, text: 'Theme Settings', onTap: () { Navigator.pop(ctx); Get.toNamed('/theme-settings'); }),
          const SizedBox(height: 20),
        ]),
      )),
    );
  }
}

class MobileMenuItem extends StatelessWidget {
  final IconData icon; final String text; final VoidCallback onTap;
  const MobileMenuItem({required this.icon, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => ListTile(
      leading: FaIcon(icon, color: tc.accentColor),
      title: Text(text, style: GoogleFonts.inter(color: tc.textPrimary, fontWeight: FontWeight.w500)),
      onTap: onTap,
    ));
  }
}

class AnimatedLogo extends StatefulWidget {
  final Color accentColor;
  const AnimatedLogo({required this.accentColor});
  @override
  State<AnimatedLogo> createState() => AnimatedLogoState();
}

class AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _scale,
    child: Row(children: [
      FaIcon(FontAwesomeIcons.code, color: widget.accentColor, size: 24),
      const SizedBox(width: 12),
      Text('MF', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: widget.accentColor, letterSpacing: 2)),
    ]),
  );
}

class NavItem extends StatefulWidget {
  final IconData icon; final String text; final VoidCallback onTap;
  const NavItem({required this.icon, required this.text, required this.onTap});
  @override State<NavItem> createState() => NavItemState();
}

class NavItemState extends State<NavItem> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(children: [
          FaIcon(widget.icon, size: 16, color: _hovered ? tc.accentColor : tc.textPrimary),
          const SizedBox(width: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500,
                color: _hovered ? tc.accentColor : tc.textPrimary),
            child: Text(widget.text),
          ),
        ]),
      ),
    ));
  }
}
