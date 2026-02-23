// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/theme_controller.dart';
import 'home_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                    constraints: const BoxConstraints(maxWidth: 1400),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 72 : (isTablet ? 40 : 24),
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // ── Page Title ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: _PageTitle(isMobile: isMobile),
                        ),

                        const SizedBox(height: 56),

                        // ── Profile + Bio (desktop: side by side) ──
                        isDesktop
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ScrollReveal(
                                      direction: RevealDirection.fromLeft,
                                      child: const _BioSection(),
                                    ),
                                  ),
                                  const SizedBox(width: 48),
                                  Expanded(
                                    flex: 3,
                                    child: ScrollReveal(
                                      direction: RevealDirection.fromRight,
                                      delay: const Duration(milliseconds: 150),
                                      child: const _QuickFactsCard(),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  ScrollReveal(
                                    direction: RevealDirection.fromLeft,
                                    child: const _BioSection(),
                                  ),
                                  const SizedBox(height: 24),
                                  ScrollReveal(
                                    direction: RevealDirection.fromRight,
                                    delay: const Duration(milliseconds: 100),
                                    child: const _QuickFactsCard(),
                                  ),
                                ],
                              ),

                        const SizedBox(height: 56),

                        // ── Section: Info Cards ──
                        ScrollReveal(
                          direction: RevealDirection.fromLeft,
                          child: _SectionHeader(
                            label: 'My Story',
                            subtitle: 'Education, experience & achievements',
                          ),
                        ),
                        const SizedBox(height: 32),

                        _InfoCardsGrid(isDesktop: isDesktop, isTablet: isTablet),

                        const SizedBox(height: 56),

                        // ── Section: What I value ──
                        ScrollReveal(
                          direction: RevealDirection.fromRight,
                          child: _SectionHeader(
                            label: 'What I Value',
                            subtitle: 'Principles I bring to every project',
                          ),
                        ),
                        const SizedBox(height: 32),

                        _ValuesRow(isMobile: isMobile,isTablet: isTablet,),

                        const SizedBox(height: 56),

                        // ── CTA ──
                        ScrollReveal(
                          direction: RevealDirection.fromBottom,
                          child: _CtaBanner(),
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
          icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 14, color: tc.accentColor),
          label: Text('Back', style: GoogleFonts.inter(color: tc.accentColor, fontWeight: FontWeight.w500)),
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
//  PAGE TITLE
// ═══════════════════════════════════════════════════════════════

class _PageTitle extends StatelessWidget {
  final bool isMobile;
  const _PageTitle({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 4, height: 52,
            decoration: BoxDecoration(color: tc.accentColor, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Me',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.w700,
                  color: tc.textPrimary,
                  height: 1.0,
                )),
              const SizedBox(height: 6),
              Text('Get to know the person behind the code.',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 13 : 17,
                  color: tc.textSecondary,
                )),
            ],
          ),
        ]),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  BIO SECTION
// ═══════════════════════════════════════════════════════════════

class _BioSection extends StatelessWidget {
  const _BioSection();

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar placeholder with gradient ring
        Container(
          width: 100, height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF00F5FF), Color(0xFF7B61FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(shape: BoxShape.circle, color: tc.cardColor),
            child: ClipOval(
              child: Image.asset('assets/images/cv.png', fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('Muhammad Faraz',
          style: GoogleFonts.poppins(
            fontSize: 22, fontWeight: FontWeight.w700, color: tc.textPrimary)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: tc.accentColor.withOpacity(0.1),
            border: Border.all(color: tc.accentColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Flutter Developer',
            style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: tc.accentColor, letterSpacing: 1.5)),
        ),
        const SizedBox(height: 20),
        Text(
          'I\'m a passionate Flutter developer with a love for crafting beautiful, '
          'high-performance mobile apps. I thrive at the intersection of clean code '
          'and great design — turning complex ideas into seamless experiences.',
          style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary, height: 1.7),
        ),
        const SizedBox(height: 20),
        Text(
          'Currently building production-grade apps at Covero, I\'ve shipped 11+ apps '
          'across Play Store and App Store, reaching thousands of real users.',
          style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary, height: 1.7),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  QUICK FACTS CARD
// ═══════════════════════════════════════════════════════════════

class _QuickFactsCard extends StatelessWidget {
  const _QuickFactsCard();

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    final facts = [
      _Fact(icon: FontAwesomeIcons.locationDot,   label: 'Location',   value: 'Pakistan'),
      _Fact(icon: FontAwesomeIcons.briefcase,      label: 'Company',    value: 'Covero'),
      _Fact(icon: FontAwesomeIcons.graduationCap,  label: 'Degree',     value: 'BS Computer Science'),
      _Fact(icon: FontAwesomeIcons.mobileScreen,   label: 'Apps Live',  value: '11+ Published Apps'),
      _Fact(icon: FontAwesomeIcons.code,           label: 'Specialty',  value: 'Flutter, Firebase & APIs, '),
      _Fact(icon: FontAwesomeIcons.envelope,       label: 'Email',      value: 'farazj105@gmail.com'),
      _Fact(icon: FontAwesomeIcons.phone,          label: 'Phone',      value: '+92 307 021 7843'),
    ];

    return Obx(() => Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: tc.cardColor,
        border: Border.all(color: tc.borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            FaIcon(FontAwesomeIcons.circleInfo, size: 14, color: tc.accentColor),
            const SizedBox(width: 8),
            Text('Quick Facts',
              style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w600, color: tc.textPrimary)),
          ]),
          const SizedBox(height: 20),
          ...facts.map((f) => _FactRow(fact: f)).toList(),
        ],
      ),
    ));
  }
}

class _Fact {
  final IconData icon;
  final String label;
  final String value;
  const _Fact({required this.icon, required this.label, required this.value});
}

class _FactRow extends StatelessWidget {
  final _Fact fact;
  const _FactRow({required this.fact});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(children: [
        SizedBox(
          width: 32,
          child: FaIcon(fact.icon, size: 14, color: tc.accentColor),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(fact.label,
            style: GoogleFonts.inter(
              fontSize: 12, color: tc.textSecondary, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Text(fact.value,
            style: GoogleFonts.inter(
              fontSize: 13, color: tc.textPrimary, fontWeight: FontWeight.w600)),
        ),
      ]),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  SECTION HEADER
// ═══════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String label;
  final String subtitle;
  const _SectionHeader({required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
          style: GoogleFonts.poppins(
            fontSize: 28, fontWeight: FontWeight.w700, color: tc.textPrimary)),
        Text(subtitle,
          style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary)),
      ]),
      const SizedBox(width: 20),
      Expanded(child: Container(height: 1, color: tc.borderColor)),
    ]));
  }
}

// ═══════════════════════════════════════════════════════════════
//  INFO CARDS GRID
// ═══════════════════════════════════════════════════════════════

class _InfoCardsGrid extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  const _InfoCardsGrid({required this.isDesktop, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _CardData(
        icon: FontAwesomeIcons.userTie,
        title: 'Who I Am',
        color: const Color(0xFF00F5FF),
        points: [
          'Passionate Flutter & Dart developer',
          'Focused on clean, maintainable code',
          'Love creating seamless UX experiences',
          'Always learning new technologies',
        ],
      ),
      _CardData(
        icon: FontAwesomeIcons.graduationCap,
        title: 'Education',
        color: const Color(0xFF7B61FF),
        points: [
          'BS Computer Science',
          'Virtual University of Pakistan',
          'Strong foundations in CS fundamentals',
          'Self-taught in mobile development',
        ],
      ),
      _CardData(
        icon: FontAwesomeIcons.briefcase,
        title: 'Experience',
        color: const Color(0xFF3DDC84),
        points: [
          'Flutter Developer at Covero (current)',
          'Previously at Propertier.com.pk',
          '2+ years professional experience',
          'Full product lifecycle ownership',
        ],
      ),
      _CardData(
        icon: FontAwesomeIcons.trophy,
        title: 'Achievements',
        color: const Color(0xFFFFD93D),
        points: [
          '11+ apps published on stores',
          '6 apps live on Play Store',
          '4 apps live on App Store',
          'Thousands of active users',
        ],
      ),
    ];

    final int cols = isDesktop ? 2 : 1;
    final List<Widget> rows = [];

    for (int i = 0; i < cards.length; i += cols) {
      final rowCards = cards.sublist(i, (i + cols).clamp(0, cards.length));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowCards.asMap().entries.map((e) {
            final idx = i + e.key;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: (e.key < rowCards.length - 1) ? (isDesktop ? 20.0 : 0.0) : 0,
                ),
                child: ScrollReveal(
                  direction: e.key.isEven ? RevealDirection.fromLeft : RevealDirection.fromRight,
                  delay: Duration(milliseconds: (idx % cols) * 120),
                  child: _InfoCard(data: e.value),
                ),
              ),
            );
          }).toList(),
        ),
      );
      if (i + cols < cards.length) rows.add(const SizedBox(height: 20));
    }

    return Column(children: rows);
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final Color color;
  final List<String> points;
  const _CardData({required this.icon, required this.title, required this.color, required this.points});
}

class _InfoCard extends StatefulWidget {
  final _CardData data;
  const _InfoCard({required this.data});
  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 1.02)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _hovered ? tc.hoverColor : tc.cardColor,
            border: Border.all(
              color: _hovered ? widget.data.color : tc.borderColor,
              width: _hovered ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: _hovered
                ? [BoxShadow(color: widget.data.color.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 6))]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + title row
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.data.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FaIcon(widget.data.icon, size: 18, color: widget.data.color),
                ),
                const SizedBox(width: 14),
                Text(widget.data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600, color: tc.textPrimary)),
              ]),
              const SizedBox(height: 18),
              // Bullet points
              ...widget.data.points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6, height: 6,
                      decoration: BoxDecoration(
                        color: widget.data.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(point,
                        style: GoogleFonts.inter(
                          fontSize: 13.5, color: tc.textSecondary, height: 1.5)),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  VALUES ROW
// ═══════════════════════════════════════════════════════════════
class _ValuesRow extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  const _ValuesRow({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final values = [
      _ValueData(icon: FontAwesomeIcons.handshake,     label: 'Reliability',  sub: 'Deliver on time, every time'),
      _ValueData(icon: FontAwesomeIcons.paintbrush,    label: 'Craft',        sub: 'Care for every pixel & line'),
      _ValueData(icon: FontAwesomeIcons.arrowTrendUp,  label: 'Growth',       sub: 'Always improving my skills'),
      _ValueData(icon: FontAwesomeIcons.users,         label: 'Teamwork',     sub: 'Better together, always'),
    ];

    // Responsive values
    final int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    final double spacing = isMobile ? 10 : (isTablet ? 14 : 16);
    final double aspectRatio = isMobile ? 1.0 : (isTablet ? 1.1 : 1.14);
    final double padding = isMobile ? 4.0 : (isTablet ? 6.0 : 8.0);
    final int delayMultiplier = isMobile ? 80 : (isTablet ? 90 : 100);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: aspectRatio,
      children: values.asMap().entries.map((e) => Padding(
        padding: EdgeInsets.all(padding),
        child: ScrollReveal(
          direction: isMobile 
              ? (e.key.isEven ? RevealDirection.fromLeft : RevealDirection.fromRight)
              : RevealDirection.fromBottom,
          delay: Duration(milliseconds: e.key * delayMultiplier),
          child: _ValueCard(data: e.value),
        ),
      )).toList(),
    );
  }
}

class _ValueData {
  final IconData icon;
  final String label;
  final String sub;
  const _ValueData({required this.icon, required this.label, required this.sub});
}

class _ValueCard extends StatefulWidget {
  final _ValueData data;
  const _ValueCard({required this.data});
  @override State<_ValueCard> createState() => _ValueCardState();
}

class _ValueCardState extends State<_ValueCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered ? tc.accentColor.withOpacity(0.08) : tc.cardColor,
          border: Border.all(color: _hovered ? tc.accentColor : tc.borderColor),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(widget.data.icon, size: 24, color: tc.accentColor),
            const SizedBox(height: 12),
            Text(widget.data.label,
              style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600, color: tc.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(widget.data.sub,
              style: GoogleFonts.inter(fontSize: 11, color: tc.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  CTA BANNER
// ═══════════════════════════════════════════════════════════════

class _CtaBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return Obx(() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tc.accentColor.withOpacity(0.12), const Color(0xFF7B61FF).withOpacity(0.12)],
        ),
        border: Border.all(color: tc.accentColor.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Text('Want to work together?',
          style: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w700, color: tc.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text("I'm open to freelance projects, full-time roles, and collaborations.",
          style: GoogleFonts.inter(fontSize: 14, color: tc.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CtaButton(
              label: 'View Projects',
              icon: FontAwesomeIcons.briefcase,
              onTap: () => Get.toNamed('/projects'),
              primary: true,
            ),
            const SizedBox(width: 12),
            _CtaButton(
              label: 'Contact Me',
              icon: FontAwesomeIcons.envelope,
              onTap: () => Get.toNamed('/contact'),
              primary: false,
            ),
          ],
        ),
      ]),
    ));
  }
}

class _CtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;
  const _CtaButton({required this.label, required this.icon, required this.onTap, required this.primary});
  @override State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<ThemeController>();
    return  MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.primary
                ? LinearGradient(colors: _hovered
                    ? [const Color(0xFF7B61FF), const Color(0xFF00F5FF)]
                    : [const Color(0xFF00F5FF), const Color(0xFF7B61FF)])
                : null,
            color: widget.primary ? null : Colors.transparent,
            border: widget.primary ? null : Border.all(color: tc.borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FaIcon(widget.icon, size: 13,
              color: widget.primary ? Colors.black : tc.textPrimary),
            const SizedBox(width: 8),
            Text(widget.label,
              style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w600,
                color: widget.primary ? Colors.black : tc.textPrimary)),
          ]),
        ),
      
    ));
  }
}