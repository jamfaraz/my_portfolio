import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../widgtes/custom_appbar.dart';
import '../widgtes/featured_project_section.dart';
import '../widgtes/footer.dart';
import '../widgtes/hero_section.dart';
import '../widgtes/why_choose_me.dart';

enum RevealDirection { fromLeft, fromRight, fromBottom, fromTop, fadeScale }

class ScrollControllerProvider extends InheritedWidget {
  final ScrollController controller;
  const ScrollControllerProvider({
    required this.controller,
    required super.child,
  });

  static ScrollController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>()
      ?.controller;

  @override
  bool updateShouldNotify(ScrollControllerProvider old) =>
      old.controller != controller;
}

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final RevealDirection direction;
  final Duration duration;
  final Duration delay;

  const ScrollReveal({
    super.key,
    required this.child,
    this.direction = RevealDirection.fromBottom,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  final GlobalKey _widgetKey = GlobalKey();
  bool _triggered = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.88,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    Offset begin;
    switch (widget.direction) {
      case RevealDirection.fromLeft:
        begin = const Offset(-0.28, 0);
        break;
      case RevealDirection.fromRight:
        begin = const Offset(0.28, 0);
        break;
      case RevealDirection.fromBottom:
        begin = const Offset(0, 0.22);
        break;
      case RevealDirection.fromTop:
        begin = const Offset(0, -0.22);
        break;
      case RevealDirection.fadeScale:
        begin = Offset.zero;
        break;
    }

    _slide = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    // Two-frame delay ensures layout is complete and GlobalKey is assigned
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
    });
  }

  void _setup() {
    if (!mounted) return;
    // Grab the root ScrollController from our InheritedWidget
    _scrollController = ScrollControllerProvider.of(context);
    _scrollController?.addListener(_checkVisibility);
    // Check immediately in case widget is already on screen
    _checkVisibility();
  }

  void _checkVisibility() {
    if (_triggered || !mounted) return;

    // Use the keyed subtree's render box to get screen position
    final box = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final screenH = MediaQuery.of(context).size.height;
    final widgetTop = box.localToGlobal(Offset.zero).dy;

    // Fire when top of widget enters bottom 90% of visible screen
    if (widgetTop < screenH * 0.92) {
      _triggered = true;
      _scrollController?.removeListener(_checkVisibility);
      if (widget.delay == Duration.zero) {
        _ctrl.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _ctrl.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_checkVisibility);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (widget.direction == RevealDirection.fadeScale) {
      result = ScaleTransition(
        scale: _scale,
        child: FadeTransition(opacity: _fade, child: widget.child),
      );
    } else {
      result = SlideTransition(
        position: _slide,
        child: FadeTransition(opacity: _fade, child: widget.child),
      );
    }
    // KeyedSubtree gives _widgetKey a stable RenderObject to localToGlobal from
    return KeyedSubtree(key: _widgetKey, child: result);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: themeController.backgroundGradient,
          ),
          child: ScrollControllerProvider(
            controller: _scrollCtrl,
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              child: Column(
                children: [
                  const CustomAppBar(),
                  const HeroSection(),
                  const SizedBox(height: 80),

                  // "Why Choose Me" — internally handles scroll reveal per element
                  const WhyChooseMeSection(),
                  const SizedBox(height: 80),

                  // "Featured Projects" — internally handles scroll reveal per element
                  const FeaturedProjectsSection(),
                  const SizedBox(height: 80),

                  // Footer fades up from bottom
                  const ScrollReveal(
                    direction: RevealDirection.fromBottom,
                    child: Footer(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
