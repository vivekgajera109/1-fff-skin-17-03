import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../provider/onboarding_provider.dart';
import 'home_screen.dart';
import '../common/common_button/common_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding(OnboardingProvider provider) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    await provider.completeOnboarding();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Consumer<OnboardingProvider>(
        builder: (context, provider, _) {
          final pages = provider.pages;
          final isLastPage = provider.currentPage == pages.length - 1;

          return Stack(
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
                        DesignTokens.primary.withOpacity(0.06),
                        DesignTokens.background,
                      ],
                    ),
                  ),
                ),
              ),
              PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => provider.updateCurrentPage(index),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildUniquePageContent(pages[index], index);
                },
              ),
              // Technical HUD Overlays

              Positioned(
                bottom: 80,
                left: 32,
                right: 32,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) =>
                            _buildUniqueIndicator(index, provider.currentPage),
                      ),
                    ),
                    const SizedBox(height: 56),
                    CyberButton(
                      text: isLastPage ? "INITIALIZE SECTOR" : "NEXT ARCHIVE",
                      icon: isLastPage
                          ? Icons.power_settings_new_rounded
                          : Icons.keyboard_arrow_right_rounded,
                      onPressed: () async {
                        if (isLastPage) {
                          _finishOnboarding(provider);
                        } else {
                          await CommonOnTap.openUrl();
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          if (!context.mounted) return;
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutQuart,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUniqueIndicator(int index, int currentPage) {
    bool isActive = index == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 2,
      width: isActive ? 40 : 12,
      decoration: BoxDecoration(
        color: isActive
            ? DesignTokens.primary
            : DesignTokens.textSecondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(1),
        boxShadow: isActive
            ? [
                BoxShadow(
                    color: DesignTokens.primary.withOpacity(0.5), blurRadius: 8)
              ]
            : null,
      ),
    );
  }

  Widget _buildUniquePageContent(OnboardingPage page, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Luxury Image HUD
          Hero(
            tag: 'onboarding_img_$index',
            child: CyberImageFrame(
              imagePath: page.image,
              accentColor: DesignTokens.primary,
              height: 280,
            ),
          ),
          const SizedBox(height: 64),
          // Technical Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
            ),
            child: Text(
              "SECTOR ${index + 1} / DATA LOG",
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: DesignTokens.primary,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            page.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              page.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: DesignTokens.textSecondary,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 140), // Large spacer for bottom panel
        ],
      ),
    );
  }
}
