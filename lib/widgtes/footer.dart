
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: tc.borderColor))),
      child: Column(children: [
        Text('© 2026 Muhammad Faraz. All rights reserved.',
            style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary), textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Built with Flutter', style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary)),
          const SizedBox(width: 8),
          const FaIcon(FontAwesomeIcons.heart, size: 12, color: Color(0xFFFF6B6B)),
        ]),
      ]),
    ));
  }
}
