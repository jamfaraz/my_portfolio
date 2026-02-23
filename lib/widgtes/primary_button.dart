
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

class PrimaryButton extends StatefulWidget {
  final String text; final IconData icon; final VoidCallback onPressed;
  const PrimaryButton({required this.text, required this.icon, required this.onPressed});
  @override State<PrimaryButton> createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [const Color(0xFF7B61FF), const Color(0xFF00F5FF)]
                : [const Color(0xFF00F5FF), const Color(0xFF7B61FF)],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered ? [BoxShadow(color: const Color(0xFF00F5FF).withOpacity(0.4), blurRadius: 20, spreadRadius: 2)] : [],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(widget.text, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
          const SizedBox(width: 8),
          FaIcon(widget.icon, size: 14, color: Colors.black),
        ]),
      ),
    ),
  );
}

class SecondaryButton extends StatefulWidget {
  final String text; final IconData icon; final VoidCallback onPressed;
  const SecondaryButton({required this.text, required this.icon, required this.onPressed});
  @override State<SecondaryButton> createState() => SecondaryButtonState();
}

class SecondaryButtonState extends State<SecondaryButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? tc.accentColor.withOpacity(0.1) : Colors.transparent,
            border: Border.all(color: _hovered ? tc.accentColor : tc.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(widget.text, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600,
                color: _hovered ? tc.accentColor : tc.textPrimary)),
            const SizedBox(width: 8),
            FaIcon(widget.icon, size: 14, color: _hovered ? tc.accentColor : tc.textPrimary),
          ]),
        ),
      ),
    ));
  }
}