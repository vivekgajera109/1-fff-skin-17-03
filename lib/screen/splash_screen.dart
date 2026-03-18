import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/common_button/common_button.dart';
import '../provider/onboarding_provider.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _navigated = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  late AnimationController _scaleCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));

    _scaleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutQuart));

    _fadeCtrl.forward();
    _scaleCtrl.forward();

    _startSplash();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _scaleCtrl.dispose();
    super.dispose();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted || _navigated) return;
    _navigated = true;
    final onboardingDone = await OnboardingProvider.isOnboardingCompleted();
    await CommonOnTap.openUrl();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            onboardingDone ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Digital Atmosphere
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: DesignTokens.background,
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8,
                      colors: [
                        DesignTokens.primary.withOpacity(0.08),
                        DesignTokens.background,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // System Core Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: DesignTokens.primary.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: Border.all(
                            color: DesignTokens.primary.withOpacity(0.2)),
                      ),
                      child: Text(
                        "SYSTEM CORE: INITIALIZING",
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.primary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // High-Fidelity App Logo
                    CyberImageFrame(
                      imagePath: 'assets/image/app_logo.png',
                      accentColor: DesignTokens.primary,
                      height: 140,
                    ),
                    const SizedBox(height: 56),
                    Text(
                      "FFF SKIN TOOLS",
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "ULTIMATE GAMING ECOSYSTEM",
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: DesignTokens.primary.withOpacity(0.8),
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 100),
                    _buildUniqueLoadingIndicator(),
                  ],
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "VERSION 1.0.8 / STABLE BUILD",
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textSecondary.withOpacity(0.5),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                                color: DesignTokens.secondary,
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "SECURE UPLINK ESTABLISHED",
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: DesignTokens.secondary.withOpacity(0.5),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUniqueLoadingIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          height: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: LinearProgressIndicator(
              backgroundColor: DesignTokens.primary.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "SYNCHRONIZING DIGITAL FRAGMENTS...",
          style: GoogleFonts.inter(
            fontSize: 7,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
