import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/theme_controller.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    final isMobile = size.width <= 600;

    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: themeController.backgroundGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(context, themeController, isDesktop),
                
                // Content
                Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
                    vertical: isDesktop ? 60 : 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Theme Settings',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 32 : 48,
                          fontWeight: FontWeight.w700,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Customize your experience',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: themeController.textSecondary,
                        ),
                      ),
                      
                      const SizedBox(height: 60),
                      
                      // Dark Mode Toggle
                      _buildDarkModeCard(themeController),
                      
                      const SizedBox(height: 40),
                      
                      // Color Schemes
                      Text(
                        'Color Schemes',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.w600,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose your favorite color palette',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: themeController.textSecondary,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Color Scheme Grid
                      _buildColorSchemeGrid(context, themeController, isDesktop, isTablet),
                      
                      const SizedBox(height: 60),
                      
                      // Preview Section
                      Text(
                        'Preview',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.w600,
                          color: themeController.textPrimary,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      _buildPreviewSection(themeController, isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeController themeController, bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 24,
      ),
      child: Row(
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: themeController.textPrimary,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 16),
          FaIcon(
            FontAwesomeIcons.palette,
            color: themeController.accentColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Theme Settings',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: themeController.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeCard(ThemeController themeController) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: themeController.cardColor,
          border: Border.all(color: themeController.borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    themeController.accentColor,
                    themeController.secondaryAccent,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(
                themeController.isDarkMode
                    ? FontAwesomeIcons.moon
                    : FontAwesomeIcons.sun,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dark Mode',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: themeController.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Toggle between light and dark theme',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: themeController.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: themeController.isDarkMode,
              onChanged: (value) => themeController.toggleTheme(),
              activeColor: themeController.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSchemeGrid(
    BuildContext context,
    ThemeController themeController,
    bool isDesktop,
    bool isTablet,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);
        double spacing = 16;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 1.1,
          ),
          itemCount: ColorSchemeType.values.length,
          itemBuilder: (context, index) {
            final schemeType = ColorSchemeType.values[index];
            final scheme = _getSchemeForType(schemeType);
            final isSelected = themeController.selectedColorScheme == schemeType;

            return _ColorSchemeCard(
              scheme: scheme,
              schemeType: schemeType,
              isSelected: isSelected,
              onTap: () => themeController.changeColorScheme(schemeType),
            );
          },
        );
      },
    );
  }

  Widget _buildPreviewSection(ThemeController themeController, bool isMobile) {
    return Obx(
      () => Column(
        children: [
          // Gradient Card
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeController.accentColor,
                  themeController.secondaryAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.paintbrush,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Primary Gradient',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Using ${themeController.colorScheme.name} color scheme',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Buttons Preview
          Row(
            children: [
              Expanded(
                child: _PreviewButton(
                  text: 'Primary',
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PreviewButton(
                  text: 'Secondary',
                  isPrimary: false,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Card Preview
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: themeController.cardColor,
              border: Border.all(color: themeController.borderColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: themeController.accentColor.withOpacity(0.2),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: themeController.accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Preview',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeController.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This is how cards will look',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: themeController.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: themeController.accentColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppColorScheme _getSchemeForType(ColorSchemeType type) {
    switch (type) {
      case ColorSchemeType.cyanPurple:
        return AppColorScheme.cyanPurple;
      case ColorSchemeType.modernBlue:
        return AppColorScheme.modernBlue;
      case ColorSchemeType.orangeBlue:
        return AppColorScheme.orangeBlue;
      case ColorSchemeType.greenTeal:
        return AppColorScheme.greenTeal;
      case ColorSchemeType.magentaPurple:
        return AppColorScheme.magentaPurple;
      case ColorSchemeType.sunsetOrange:
        return AppColorScheme.sunsetOrange;
      case ColorSchemeType.mintGreen:
        return AppColorScheme.mintGreen;
      case ColorSchemeType.royalGold:
        return AppColorScheme.royalGold;
    }
  }
}

class _ColorSchemeCard extends StatefulWidget {
  final AppColorScheme scheme;
  final ColorSchemeType schemeType;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorSchemeCard({
    required this.scheme,
    required this.schemeType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ColorSchemeCard> createState() => _ColorSchemeCardState();
}

class _ColorSchemeCardState extends State<_ColorSchemeCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? themeController.accentColor.withOpacity(0.05)
                  : themeController.cardColor,
              border: Border.all(
                color: widget.isSelected
                    ? themeController.accentColor
                    : (_isHovered
                        ? themeController.accentColor.withOpacity(0.5)
                        : themeController.borderColor),
                width: widget.isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: widget.isSelected || _isHovered
                  ? [
                      BoxShadow(
                        color: widget.scheme.primary.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Color Circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ColorCircle(color: widget.scheme.primary, size: 36),
                    const SizedBox(width: 10),
                    _ColorCircle(color: widget.scheme.secondary, size: 36),
                    const SizedBox(width: 10),
                    _ColorCircle(color: widget.scheme.tertiary, size: 36),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Scheme Name
                Text(
                  widget.scheme.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: themeController.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Description
                Text(
                  widget.scheme.description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: themeController.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Selected Indicator
                if (widget.isSelected) ...[
                  const SizedBox(height: 12),
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: themeController.accentColor,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _ColorCircle({
    required this.color,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _PreviewButton extends StatefulWidget {
  final String text;
  final bool isPrimary;

  const _PreviewButton({
    required this.text,
    required this.isPrimary,
  });

  @override
  State<_PreviewButton> createState() => _PreviewButtonState();
}

class _PreviewButtonState extends State<_PreviewButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: _isHovered
                        ? [
                            themeController.secondaryAccent,
                            themeController.accentColor
                          ]
                        : [
                            themeController.accentColor,
                            themeController.secondaryAccent
                          ],
                  )
                : null,
            color: !widget.isPrimary
                ? (_isHovered
                    ? themeController.accentColor.withOpacity(0.1)
                    : Colors.transparent)
                : null,
            border: !widget.isPrimary
                ? Border.all(
                    color: _isHovered
                        ? themeController.accentColor
                        : themeController.borderColor,
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: themeController.accentColor.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: widget.isPrimary
                    ? Colors.black
                    : (_isHovered
                        ? themeController.accentColor
                        : themeController.textPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}