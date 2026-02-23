
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/theme_controller.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Row(
      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: const [
        SocialIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/jamfaraz'),
        SizedBox(width: 12),
        SocialIcon(icon: FontAwesomeIcons.linkedin, url: 'https://linkedin.com/in/muhammad-faraz1035bb297'),
        SizedBox(width: 12),
        SocialIcon(icon: FontAwesomeIcons.envelope, url: 'mailto:farazj105@gmail.com'),
        SizedBox(width: 12),
        SocialIcon(icon: FontAwesomeIcons.phone, url: 'tel:+923070217843'),
      ],
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon; final String url;
  const SocialIcon({required this.icon, required this.url});
  @override State<SocialIcon> createState() => SocialIconState();
}

class SocialIconState extends State<SocialIcon> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: GestureDetector(
        onTap: () async { final u = Uri.parse(widget.url); if (await canLaunchUrl(u)) launchUrl(u); },
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hovered ? tc.accentColor.withOpacity(0.1) : Colors.transparent,
              border: Border.all(color: _hovered ? tc.accentColor : tc.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(widget.icon, color: _hovered ? tc.accentColor : tc.textPrimary, size: 16),
          ),
        ),
      ),
    ));
  }
}
