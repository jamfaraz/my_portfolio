import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
              'Get In Touch',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 36 : 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let\'s discuss your next project',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFFB8B8D1),
              ),
            ),
            const SizedBox(height: 60),
            // Contact Info Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isMobile ? 2 : 2.5,
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
                  value: 'Basti Malook, Multan, Pakistan',
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
            ),
            const SizedBox(height: 60),
            // Social Media Section
            Center(
              child: Column(
                children: [
                  Text(
                    'Connect With Me',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
                        url:
                            'https://linkedin.com/in/muhammad-faraz1035bb297',
                        color: Color(0xFF0A84FF),
                      ),
                      _SocialButton(
                        icon: FontAwesomeIcons.whatsapp,
                        label: 'WhatsApp',
                        url: 'https://wa.me/923070217843',
                        color: Color(0xFF25D366),
                      ),
                      _SocialButton(
                        icon: FontAwesomeIcons.telegram,
                        label: 'Telegram',
                        url: 'https://t.me/+923070217843',
                        color: Color(0xFF0088CC),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            // CTA Section
            Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A1E3E),
                    Color(0xFF0F1229),
                  ],
                ),
                border: Border.all(color: const Color(0xFF2A2E4E)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.rocket,
                    size: 48,
                    color: Color(0xFF00F5FF),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ready to Start a Project?',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'I\'m available for freelance work and full-time positions.\nLet\'s create something amazing together!',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFFB8B8D1),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _CTAButton(
                        text: 'Send Email',
                        icon: FontAwesomeIcons.envelope,
                        onPressed: () =>
                            _launchURL('mailto:farazj105@gmail.com'),
                        isPrimary: true,
                      ),
                      _CTAButton(
                        text: 'Call Me',
                        icon: FontAwesomeIcons.phone,
                        onPressed: () => _launchURL('tel:+923070217843'),
                        isPrimary: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.url.isNotEmpty
            ? () => _launchURL(widget.url)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF1A1E3E)
                : const Color(0xFF0F1229),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF00F5FF)
                  : const Color(0xFF2A2E4E),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
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
                  size: 28,
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
                        color: const Color(0xFF8A8AA8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                size: 20,
                color: widget.color,
              ),
              const SizedBox(width: 12),
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

class _CTAButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _CTAButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: _isHovered
                        ? [
                            const Color(0xFF7B61FF),
                            const Color(0xFF00F5FF)
                          ]
                        : [
                            const Color(0xFF00F5FF),
                            const Color(0xFF7B61FF)
                          ],
                  )
                : null,
            color: widget.isPrimary
                ? null
                : _isHovered
                    ? const Color(0xFF00F5FF).withOpacity(0.1)
                    : Colors.transparent,
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered
                        ? const Color(0xFF00F5FF)
                        : const Color(0xFF3A3E5E),
                  ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: widget.isPrimary
                    ? Colors.black
                    : _isHovered
                        ? const Color(0xFF00F5FF)
                        : Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: widget.isPrimary
                      ? Colors.black
                      : _isHovered
                          ? const Color(0xFF00F5FF)
                          : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}