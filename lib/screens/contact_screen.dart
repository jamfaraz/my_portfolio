// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/theme_controller.dart';
import 'home_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Scaffold(
      body: Obx(() => Container(
        decoration: BoxDecoration(gradient: tc.backgroundGradient),
        child: ScrollControllerProvider(
          controller: _scrollCtrl,
          child: SingleChildScrollView(
            controller: _scrollCtrl,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── App Bar ──
                  _AppBar(),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 72 : (isTablet ? 40 : 24),
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // ── Hero Header ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: _PageHeader(isMobile: isMobile),
                        ),

                        const SizedBox(height: 56),

                        // ── Contact Info Cards ──
                        isDesktop
                            ? _DesktopContactLayout()
                            : _MobileContactLayout(isTablet: isTablet),

                        const SizedBox(height: 64),

                        // ── Social Section ──
                        ScrollReveal(
                          direction: RevealDirection.fromBottom,
                          child: _SocialSection(isMobile: isMobile),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  APP BAR
// ═══════════════════════════════════════════════════════════════

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        TextButton.icon(
          onPressed: () => Get.back(),
          icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 13, color: tc.accentColor),
          label: Text('Back', style: GoogleFonts.inter(color: tc.accentColor, fontWeight: FontWeight.w500, fontSize: 14)),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: tc.accentColor.withOpacity(0.3)),
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: FaIcon(
            tc.isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
            color: tc.accentColor, size: 18,
          ),
          onPressed: () => tc.toggleTheme(),
        ),
      ]),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  PAGE HEADER
// ═══════════════════════════════════════════════════════════════

class _PageHeader extends StatelessWidget {
  final bool isMobile;
  const _PageHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: tc.accentColor.withOpacity(0.1),
            border: Border.all(color: tc.accentColor.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FaIcon(FontAwesomeIcons.paperPlane, size: 11, color: tc.accentColor),
            const SizedBox(width: 8),
            Text('AVAILABLE FOR WORK', style: GoogleFonts.inter(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: tc.accentColor, letterSpacing: 1.5,
            )),
          ]),
        ),
        const SizedBox(height: 20),

        // Title
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: 4, height: isMobile ? 40 : 52,
            decoration: BoxDecoration(
              color: tc.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "Get In Touch",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 34 : 56,
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
              height: 1.0,
            ),
          ),
        ]),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Have a project in mind? Let's build something\namazing together.",
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 17,
              color: tc.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  DESKTOP LAYOUT — left: contact cards, right: big CTA card
// ═══════════════════════════════════════════════════════════════

class _DesktopContactLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left — contact info cards stacked
        Expanded(
          flex: 5,
          child: Column(children: [
            ScrollReveal(
              direction: RevealDirection.fromLeft,
              delay: const Duration(milliseconds: 0),
              child: const _ContactCard(
                icon: FontAwesomeIcons.envelope,
                title: 'Email',
                value: 'farazj105@gmail.com',
                subtitle: 'Best way to reach me',
                url: 'mailto:farazj105@gmail.com',
                gradient: LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFCC4444)]),
                copyable: true,
              ),
            ),
            const SizedBox(height: 16),
            ScrollReveal(
              direction: RevealDirection.fromLeft,
              delay: const Duration(milliseconds: 100),
              child: const _ContactCard(
                icon: FontAwesomeIcons.phone,
                title: 'Phone / WhatsApp',
                value: '+92 307 021 7843',
                subtitle: 'Available 9am – 9pm PKT',
                url: 'tel:+923070217843',
                gradient: LinearGradient(colors: [Color(0xFF00F5FF), Color(0xFF0099CC)]),
                copyable: true,
              ),
            ),
            const SizedBox(height: 16),
            ScrollReveal(
              direction: RevealDirection.fromLeft,
              delay: const Duration(milliseconds: 200),
              child: const _ContactCard(
                icon: FontAwesomeIcons.locationDot,
                title: 'Location',
                value: 'Multan, Pakistan',
                subtitle: 'Open to remote work globally',
                url: '',
                gradient: LinearGradient(colors: [Color(0xFF6BCF7F), Color(0xFF2ECC71)]),
                copyable: false,
              ),
            ),
            const SizedBox(height: 16),
            ScrollReveal(
              direction: RevealDirection.fromLeft,
              delay: const Duration(milliseconds: 300),
              child: const _ContactCard(
                icon: FontAwesomeIcons.briefcase,
                title: 'Currently At',
                value: 'Covero Company',
                subtitle: 'Flutter Developer',
                url: '',
                gradient: LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)]),
                copyable: false,
              ),
            ),
          ]),
        ),

        const SizedBox(width: 28),

        // Right — CTA card
        Expanded(
          flex: 4,
          child: ScrollReveal(
            direction: RevealDirection.fromRight,
            child: const _CTACard(),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  MOBILE/TABLET LAYOUT — stacked
// ═══════════════════════════════════════════════════════════════

class _MobileContactLayout extends StatelessWidget {
  final bool isTablet;
  const _MobileContactLayout({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final cards = [
      const _ContactCard(
        icon: FontAwesomeIcons.envelope,
        title: 'Email',
        value: 'farazj105@gmail.com',
        subtitle: 'Best way to reach me',
        url: 'mailto:farazj105@gmail.com',
        gradient: LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFCC4444)]),
        copyable: true,
      ),
      const _ContactCard(
        icon: FontAwesomeIcons.phone,
        title: 'Phone / WhatsApp',
        value: '+92 307 021 7843',
        subtitle: 'Available 9am – 9pm PKT',
        url: 'tel:+923070217843',
        gradient: LinearGradient(colors: [Color(0xFF00F5FF), Color(0xFF0099CC)]),
        copyable: true,
      ),
      const _ContactCard(
        icon: FontAwesomeIcons.locationDot,
        title: 'Location',
        value: 'Multan, Pakistan',
        subtitle: 'Open to remote work globally',
        url: '',
        gradient: LinearGradient(colors: [Color(0xFF6BCF7F), Color(0xFF2ECC71)]),
        copyable: false,
      ),
      const _ContactCard(
        icon: FontAwesomeIcons.briefcase,
        title: 'Currently At',
        value: 'Covero Company',
        subtitle: 'Flutter Developer',
        url: '',
        gradient: LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF5B41CC)]),
        copyable: false,
      ),
    ];

    if (isTablet) {
      // 2-column grid on tablet
      return Column(children: [
        Row(children: [
          Expanded(child: ScrollReveal(direction: RevealDirection.fromLeft, child: cards[0])),
          const SizedBox(width: 16),
          Expanded(child: ScrollReveal(direction: RevealDirection.fromRight, child: cards[1])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: ScrollReveal(direction: RevealDirection.fromLeft, delay: const Duration(milliseconds: 100), child: cards[2])),
          const SizedBox(width: 16),
          Expanded(child: ScrollReveal(direction: RevealDirection.fromRight, delay: const Duration(milliseconds: 100), child: cards[3])),
        ]),
        const SizedBox(height: 28),
        ScrollReveal(direction: RevealDirection.fromBottom, child: const _CTACard()),
      ]);
    }

    // Single column on mobile
    return Column(children: [
      for (int i = 0; i < cards.length; i++) ...[
        ScrollReveal(
          direction: i.isEven ? RevealDirection.fromLeft : RevealDirection.fromRight,
          delay: Duration(milliseconds: i * 80),
          child: cards[i],
        ),
        if (i < cards.length - 1) const SizedBox(height: 14),
      ],
      const SizedBox(height: 28),
      ScrollReveal(direction: RevealDirection.fromBottom, child: const _CTACard()),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════
//  CONTACT CARD
// ═══════════════════════════════════════════════════════════════

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final String url;
  final Gradient gradient;
  final bool copyable;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.url,
    required this.gradient,
    required this.copyable,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;
  bool _copied = false;

  void _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.value));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();

    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.url.isNotEmpty
            ? () async {
                final uri = Uri.parse(widget.url);
                if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _hovered ? tc.hoverColor : tc.cardColor,
            border: Border.all(
              color: _hovered ? tc.accentColor : tc.borderColor,
              width: _hovered ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovered
                ? [BoxShadow(color: tc.accentColor.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 6))]
                : [],
          ),
          child: Row(children: [
            // Gradient icon box
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: FaIcon(widget.icon, size: 20, color: Colors.white)),
            ),
            const SizedBox(width: 16),

            // Text
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title,
                  style: GoogleFonts.inter(fontSize: 11, color: tc.textSecondary, letterSpacing: 0.5)),
                const SizedBox(height: 3),
                Text(widget.value,
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: tc.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(widget.subtitle,
                  style: GoogleFonts.inter(fontSize: 11, color: tc.textSecondary)),
              ],
            )),

            // Action icon
            if (widget.url.isNotEmpty || widget.copyable)
              const SizedBox(width: 8),
            if (widget.copyable)
              GestureDetector(
                onTap: _handleCopy,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _copied
                      ? FaIcon(FontAwesomeIcons.check, size: 14, color: const Color(0xFF6BCF7F), key: const ValueKey('check'))
                      : FaIcon(FontAwesomeIcons.copy, size: 14, color: tc.textSecondary, key: const ValueKey('copy')),
                ),
              )
            else if (widget.url.isNotEmpty)
              FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 13,
                color: _hovered ? tc.accentColor : tc.textSecondary),
          ]),
        ),
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  CTA CARD — "Let's Work Together"
// ═══════════════════════════════════════════════════════════════

class _CTACard extends StatefulWidget {
  const _CTACard();
  @override
  State<_CTACard> createState() => _CTACardState();
}

class _CTACardState extends State<_CTACard> with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0)
        .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1B3E), Color(0xFF0A0F1E)],
        ),
        border: Border.all(color: tc.accentColor.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated availability dot
          Row(children: [
            AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF6BCF7F).withOpacity(_pulseAnim.value),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: const Color(0xFF6BCF7F).withOpacity(_pulseAnim.value * 0.6), blurRadius: 8, spreadRadius: 2)],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('Available for new projects',
              style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF6BCF7F), fontWeight: FontWeight.w500)),
          ]),

          const SizedBox(height: 20),
          Text("Let's Work\nTogether",
            style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white, height: 1.15)),

          const SizedBox(height: 12),
          Text(
            "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision.",
            style: GoogleFonts.inter(fontSize: 13.5, color: Colors.white.withOpacity(0.6), height: 1.6),
          ),

          const SizedBox(height: 28),

          // Quick action buttons
          _CTAButton(
            icon: FontAwesomeIcons.envelope,
            label: 'Send Email',
            url: 'mailto:farazj105@gmail.com',
            color: const Color(0xFFFF6B6B),
          ),
          const SizedBox(height: 10),
          _CTAButton(
            icon: FontAwesomeIcons.whatsapp,
            label: 'WhatsApp Me',
            url: 'https://wa.me/923070217843',
            color: const Color(0xFF25D366),
          ),
          const SizedBox(height: 10),
          _CTAButton(
            icon: FontAwesomeIcons.linkedin,
            label: 'LinkedIn',
            url: 'https://linkedin.com/in/muhammad-faraz1035bb297',
            color: const Color(0xFF0A84FF),
          ),
        ],
      ),
    ));
  }
}

class _CTAButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;
  const _CTAButton({required this.icon, required this.label, required this.url, required this.color});
  @override State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withOpacity(0.15) : widget.color.withOpacity(0.08),
            border: Border.all(color: _hovered ? widget.color : widget.color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            FaIcon(widget.icon, size: 14, color: widget.color),
            const SizedBox(width: 12),
            Text(widget.label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: widget.color)),
            const Spacer(),
            AnimatedOpacity(
              opacity: _hovered ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 180),
              child: FaIcon(FontAwesomeIcons.arrowRight, size: 12, color: widget.color),
            ),
          ]),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SOCIAL SECTION
// ═══════════════════════════════════════════════════════════════

class _SocialSection extends StatelessWidget {
  final bool isMobile;
  const _SocialSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: tc.cardColor,
        border: Border.all(color: tc.borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Text('Find Me Online',
          style: GoogleFonts.poppins(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.w700, color: tc.textPrimary)),
        const SizedBox(height: 8),
        Text('Connect with me on these platforms',
          style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary)),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children:  [
            _SocialButton(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              handle: '@jamfaraz',
              url: 'https://github.com/jamfaraz',
              color: Colors.amber.shade600,
            ),
            _SocialButton(
              icon: FontAwesomeIcons.linkedin,
              label: 'LinkedIn',
              handle: 'muhammad-faraz',
              url: 'https://linkedin.com/in/muhammad-faraz1035bb297',
              color: Color(0xFF0A84FF),
            ),
            _SocialButton(
              icon: FontAwesomeIcons.whatsapp,
              label: 'WhatsApp',
              handle: '+92 307 021 7843',
              url: 'https://wa.me/923070217843',
              color: Color(0xFF25D366),
            ),
          ],
        ),
      ]),
    ));
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String handle;
  final String url;
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.handle,
    required this.url,
    required this.color,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _hovered ? widget.color.withOpacity(0.12) : tc.cardColor,
              border: Border.all(
                color: _hovered ? widget.color : tc.borderColor,
                width: _hovered ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _hovered
                  ? [BoxShadow(color: widget.color.withOpacity(0.15), blurRadius: 16)]
                  : [],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(widget.icon, size: 22, color: widget.color),
                const SizedBox(height: 8),
                Text(widget.label,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: widget.color)),
                const SizedBox(height: 2),
                Text(widget.handle,
                  style: GoogleFonts.inter(fontSize: 10, color: widget.color.withOpacity(0.6))),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}