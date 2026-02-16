import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/theme_controller.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
                        'Get In Touch',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 56 : 40,
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Let\'s discuss your next project',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: themeController.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 60),
                      _buildContactCards(isDesktop, isTablet),
                      const SizedBox(height: 60),
                      _buildSocialSection(themeController),
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

  Widget _buildContactCards(bool isDesktop, bool isTablet) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 2 : 1,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      childAspectRatio: isDesktop ? 2.5 : 2.0,
      children: const [
        _ContactCard(
          icon: FontAwesomeIcons.envelope,
          title: 'Email',
          value: 'farazj105@gmail.com',
          url: 'mailto:farazj105@gmail.com',
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B6B), Color(0xFFCC5555)],
          ),
        ),
        _ContactCard(
          icon: FontAwesomeIcons.phone,
          title: 'Phone',
          value: '+92 307 0217843',
          url: 'tel:+923070217843',
          gradient: LinearGradient(
            colors: [Color(0xFF00F5FF), Color(0xFF0099CC)],
          ),
        ),
        _ContactCard(
          icon: FontAwesomeIcons.locationDot,
          title: 'Location',
          value: 'Basti Malook, Multan',
          url: '',
          gradient: LinearGradient(
            colors: [Color(0xFF6BCF7F), Color(0xFF55A666)],
          ),
        ),
        _ContactCard(
          icon: FontAwesomeIcons.briefcase,
          title: 'Currently At',
          value: 'Covero Company',
          url: '',
          gradient: LinearGradient(
            colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection(ThemeController themeController) {
    return Obx(() => Center(
      child: Column(
        children: [
          Text(
            'Connect With Me',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: themeController.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: const [
              _SocialButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: 'https://github.com/jamfaraz',
                color: Color(0xFFB8B8D1),
              ),
              _SocialButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                url: 'https://linkedin.com/in/muhammad-faraz1035bb297',
                color: Color(0xFF0A84FF),
              ),
              _SocialButton(
                icon: FontAwesomeIcons.whatsapp,
                label: 'WhatsApp',
                url: 'https://wa.me/923070217843',
                color: Color(0xFF25D366),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String url;
  final Gradient gradient;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
    required this.gradient,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.url.isNotEmpty ? () => _launchURL(widget.url) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isHovered
                ? themeController.hoverColor
                : themeController.cardColor,
            border: Border.all(
              color: _isHovered
                  ? themeController.accentColor
                  : themeController.borderColor,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  widget.icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: themeController.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: themeController.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.2)
                : widget.color.withOpacity(0.1),
            border: Border.all(
              color: _isHovered
                  ? widget.color
                  : widget.color.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 18,
                color: widget.color,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}