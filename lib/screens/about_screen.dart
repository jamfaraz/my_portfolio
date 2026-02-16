import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
            // Back Button for Mobile

            const SizedBox(height: 20),
            // Page Title
            Text(
              'About Me',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 36 : 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Get to know me better',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFFB8B8D1),
              ),
            ),
            const SizedBox(height: 60),
            // About Cards
            isMobile
                ? Column(
                    children: const [
                      _AboutCard(
                        icon: FontAwesomeIcons.userTie,
                        title: 'Who I Am',
                        description:
                            'I\'m a passionate Flutter Developer with a knack for creating dynamic and interactive mobile applications. With a solid understanding of the Dart language, Flutter framework, and Firebase, I\'ve successfully developed and deployed several applications on both the Google Play Store and Apple App Store.',
                      ),
                      SizedBox(height: 24),
                      _AboutCard(
                        icon: FontAwesomeIcons.graduationCap,
                        title: 'Education',
                        description:
                            'Pursuing BS Computer Science from Virtual University of Pakistan. Completed Intermediate from Comrade College Basti Malook and Matriculation from Ibn-e-Qasim High School with strong academic performance.',
                      ),
                      SizedBox(height: 24),
                      _AboutCard(
                        icon: FontAwesomeIcons.briefcase,
                        title: 'Experience',
                        description:
                            'Currently working at Covero Company, building innovative solutions. Previously worked at Propertier.com.pk in Islamabad, Pakistan, developing property management applications.',
                      ),
                      SizedBox(height: 24),
                      _AboutCard(
                        icon: FontAwesomeIcons.trophy,
                        title: 'Achievements',
                        description:
                            'Successfully published 8+ applications on both Google Play Store and Apple App Store. Built apps ranging from e-commerce to restaurant management systems, serving thousands of users.',
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: const [
                      SizedBox(
                        width: 600,
                        child: _AboutCard(
                          icon: FontAwesomeIcons.userTie,
                          title: 'Who I Am',
                          description:
                              'I\'m a passionate Flutter Developer with a knack for creating dynamic and interactive mobile applications. With a solid understanding of the Dart language, Flutter framework, and Firebase, I\'ve successfully developed and deployed several applications on both the Google Play Store and Apple App Store.',
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: _AboutCard(
                          icon: FontAwesomeIcons.graduationCap,
                          title: 'Education',
                          description:
                              'Pursuing BS Computer Science from Virtual University of Pakistan. Completed Intermediate from Comrade College Basti Malook and Matriculation from Ibn-e-Qasim High School with strong academic performance.',
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: _AboutCard(
                          icon: FontAwesomeIcons.briefcase,
                          title: 'Experience',
                          description:
                              'Currently working at Covero Company, building innovative solutions. Previously worked at Propertier.com.pk in Islamabad, Pakistan, developing property management applications.',
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: _AboutCard(
                          icon: FontAwesomeIcons.trophy,
                          title: 'Achievements',
                          description:
                              'Successfully published 8+ applications on both Google Play Store and Apple App Store. Built apps ranging from e-commerce to restaurant management systems, serving thousands of users.',
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 60),
            // Languages
            Text(
              'Languages',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: const [
                _LanguageCard(
                  icon: '🇵🇰',
                  language: 'Urdu',
                  proficiency: 'Native',
                ),
                _LanguageCard(
                  icon: '🇬🇧',
                  language: 'English',
                  proficiency: 'Professional',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AboutCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<_AboutCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(
              widget.icon,
              size: 40,
              color: const Color(0xFF00F5FF),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFFB8B8D1),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String icon;
  final String language;
  final String proficiency;

  const _LanguageCard({
    required this.icon,
    required this.language,
    required this.proficiency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1229),
        border: Border.all(color: const Color(0xFF2A2E4E)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                proficiency,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF00F5FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}