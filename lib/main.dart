import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Import screens
import 'screens/about_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/skils_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Faraz - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0E27),
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        textTheme: GoogleFonts.interTextTheme(
          const TextTheme(
            displayLarge: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -2,
            ),
            displayMedium: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -1,
            ),
            headlineMedium: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              color: Color(0xFFB8B8D1),
              height: 1.6,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: Color(0xFFB8B8D1),
              height: 1.5,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/about': (context) => const AboutScreen(),
        '/skills': (context) => const SkillsScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}

// Main Screen with Bottom Navigation for Mobile
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = const [
    HomeContent(),
    AboutScreen(),
    SkillsScreen(),
    ProjectsScreen(),
    ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          const AnimatedBackground(),
          Column(
            children: [
              CustomAppBar(
                scaffoldKey: _scaffoldKey,
                onNavigate: (index) {
                  if (isMobile) {
                    setState(() => _selectedIndex = index);
                  }
                },
              ),
              Expanded(
                child: isMobile
                    ? _screens[_selectedIndex]
                    : const HomeContent(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildBottomNav() : null,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1229),
        border: Border(
          top: BorderSide(color: const Color(0xFF2A2E4E), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color(0xFF00F5FF),
        unselectedItemColor: const Color(0xFF8A8AA8),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, size: 20),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.code, size: 20),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.briefcase, size: 20),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.envelope, size: 20),
            label: 'Contact',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0F1229),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00F5FF), Color(0xFF7B61FF)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Muhammad Faraz',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Flutter Developer',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(FontAwesomeIcons.house, 'Home', 0),
          _buildDrawerItem(FontAwesomeIcons.user, 'About', 1),
          _buildDrawerItem(FontAwesomeIcons.code, 'Skills', 2),
          _buildDrawerItem(FontAwesomeIcons.briefcase, 'Projects', 3),
          _buildDrawerItem(FontAwesomeIcons.envelope, 'Contact', 4),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final isSelected = _selectedIndex == index;
    return ListTile(
      leading: FaIcon(
        icon,
        color: isSelected ? const Color(0xFF00F5FF) : Colors.white,
        size: 20,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isSelected ? const Color(0xFF00F5FF) : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF00F5FF).withOpacity(0.1),
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }
}

// Custom App Bar
class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int)? onNavigate;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.code,
                  color: Color(0xFF00F5FF),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'MF',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00F5FF),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop)
            Row(
              children: [
                _NavItem(text: 'About', icon: FontAwesomeIcons.user),
                const SizedBox(width: 32),
                _NavItem(text: 'Skills', icon: FontAwesomeIcons.code),
                const SizedBox(width: 32),
                _NavItem(text: 'Projects', icon: FontAwesomeIcons.briefcase),
                const SizedBox(width: 32),
                _NavItem(text: 'Contact', icon: FontAwesomeIcons.envelope),
              ],
            )
          else
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String text;
  final IconData icon;

  const _NavItem({required this.text, required this.icon});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/${widget.text.toLowerCase()}');
        },
        child: Row(
          children: [
            FaIcon(
              widget.icon,
              size: 16,
              color: _isHovered ? const Color(0xFF00F5FF) : Colors.white,
            ),
            const SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _isHovered ? const Color(0xFF00F5FF) : Colors.white,
                letterSpacing: 0.5,
              ),
              child: Text(widget.text),
            ),
          ],
        ),
      ),
    );
  }
}

// Animated Background
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0A0E27),
                Color.lerp(
                  const Color(0xFF1A1E3E),
                  const Color(0xFF2A1E4E),
                  _controller.value,
                )!,
                const Color(0xFF0A0E27),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Home Content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          HeroSection(),
          SizedBox(height: 80),
          QuickAboutSection(),
          SizedBox(height: 80),
          FeaturedProjectsSection(),
          SizedBox(height: 80),
          Footer(),
        ],
      ),
    );
  }
}

// Hero Section
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 40 : 100,
      ),
      child: isMobile
          ? Column(
              children: [
                const _HeroImage(),
                const SizedBox(height: 40),
                _HeroContent(),
              ],
            )
          : Row(
              children: [
                Expanded(child: _HeroContent()),
                const SizedBox(width: 80),
                const _HeroImage(),
              ],
            ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00F5FF).withOpacity(0.1),
              border: Border.all(color: const Color(0xFF00F5FF)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(
                  FontAwesomeIcons.mobileScreen,
                  size: 12,
                  color: Color(0xFF00F5FF),
                ),
                const SizedBox(width: 8),
                Text(
                  'FLUTTER DEVELOPER',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00F5FF),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Text(
            'Muhammad\nFaraz',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -2,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 24),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1400),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Text(
            'Crafting beautiful, dynamic mobile experiences\nwith Flutter & Firebase. Currently building\ninnovative solutions at Covero.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 18,
              color: const Color(0xFFB8B8D1),
              height: 1.6,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 40),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1600),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment:
                isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              _PrimaryButton(
                text: 'View Projects',
                icon: FontAwesomeIcons.briefcase,
                onPressed: () {
                  Navigator.pushNamed(context, '/projects');
                },
              ),
              _SecondaryButton(
                text: 'Contact Me',
                icon: FontAwesomeIcons.envelope,
                onPressed: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        const _SocialLinks(),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: child,
          ),
        );
      },
      child: Container(
        width: isMobile ? 280 : 380,
        height: isMobile ? 280 : 380,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00F5FF),
              Color(0xFF7B61FF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F5FF).withOpacity(0.3),
              blurRadius: 60,
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipOval(
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1A1E3E),
            ),
            // Replace with actual image when available:
            child: Image.asset(
              'assets/images/cv.png',
              fit: BoxFit.cover,
            ),
            // child: const Center(
            //   child: FaIcon(
            //     FontAwesomeIcons.userTie,
            //     size: 120,
            //     color: Color(0xFF00F5FF),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MediaQuery.of(context).size.width < 800
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: const [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/jamfaraz',
        ),
        SizedBox(width: 16),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          url: 'https://linkedin.com/in/muhammad-faraz1035bb297',
        ),
        SizedBox(width: 16),
        _SocialIcon(
          icon: FontAwesomeIcons.envelope,
          url: 'mailto:farazj105@gmail.com',
        ),
        SizedBox(width: 16),
        _SocialIcon(
          icon: FontAwesomeIcons.phone,
          url: 'tel:+923070217843',
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF00F5FF).withOpacity(0.1)
                : Colors.transparent,
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF00F5FF)
                  : const Color(0xFF3A3E5E),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? const Color(0xFF00F5FF) : Colors.white,
            size: 18,
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

// Quick About Section
class QuickAboutSection extends StatelessWidget {
  const QuickAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
      child: Column(
        children: [
          Text(
            'Why Choose Me',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Delivering excellence in mobile development',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFFB8B8D1),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: isMobile ? 1.5 : 1.1,
            children: const [
              _FeatureCard(
                icon: FontAwesomeIcons.rocket,
                title: '8+ Published Apps',
                description:
                    'Successfully deployed apps on both Play Store and App Store',
              ),
              _FeatureCard(
                icon: FontAwesomeIcons.code,
                title: 'Clean Code',
                description:
                    'Writing maintainable, scalable code following best practices',
              ),
              _FeatureCard(
                icon: FontAwesomeIcons.bolt,
                title: 'Fast Delivery',
                description:
                    'Delivering high-quality projects within deadlines',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              widget.icon,
              size: 48,
              color: const Color(0xFF00F5FF),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFFB8B8D1),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Featured Projects Section
class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
      child: Column(
        children: [
          Text(
            'Featured Projects',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 60),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: isMobile ? 1.0 : 1.2,
            children: const [
              _MiniProjectCard(
                title: 'Covero Pro',
                description: 'Professional service management',
                icon: FontAwesomeIcons.briefcase,
                color: Color(0xFF00F5FF),
              ),
              _MiniProjectCard(
                title: 'MyCovero',
                description: 'Client portal application',
                icon: FontAwesomeIcons.mobileScreen,
                color: Color(0xFF7B61FF),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _PrimaryButton(
            text: 'View All Projects',
            icon: FontAwesomeIcons.arrowRight,
            onPressed: () {
              Navigator.pushNamed(context, '/projects');
            },
          ),
        ],
      ),
    );
  }
}

class _MiniProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _MiniProjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1229),
        border: Border.all(color: const Color(0xFF2A2E4E)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              border: Border.all(color: color),
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFB8B8D1),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Footer
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF2A2E4E)),
        ),
      ),
      child: Column(
        children: [
          Text(
            '© 2026 Muhammad Faraz. All rights reserved.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF8A8AA8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Built with Flutter',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF8A8AA8),
                ),
              ),
              const SizedBox(width: 8),
              const FaIcon(
                FontAwesomeIcons.heart,
                size: 12,
                color: Color(0xFFFF6B6B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Reusable Buttons
class _PrimaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [const Color(0xFF7B61FF), const Color(0xFF00F5FF)]
                  : [const Color(0xFF00F5FF), const Color(0xFF7B61FF)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
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
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              FaIcon(
                widget.icon,
                size: 14,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF00F5FF).withOpacity(0.1)
                : Colors.transparent,
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF00F5FF)
                  : const Color(0xFF3A3E5E),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      _isHovered ? const Color(0xFF00F5FF) : Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              FaIcon(
                widget.icon,
                size: 14,
                color: _isHovered ? const Color(0xFF00F5FF) : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}