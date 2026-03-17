import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../provider/onboarding_provider.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';
import '../common/common_button/common_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _NoCyberOnboardingState();
}

class _NoCyberOnboardingState extends State<OnboardingScreen> {
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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, _) {
          final pages = provider.pages;
          final isLastPage = provider.currentPage == pages.length - 1;

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        provider.updateCurrentPage(index);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final page = pages[index];
                        return _buildPageContent(page);
                      },
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 16,
                      right: 24,
                      child: TextButton(
                        onPressed: () => _finishOnboarding(provider),
                        child: Text(
                          "Skip",
                          style: GoogleFonts.outfit(
                            color: DesignTokens.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildBottomSection(provider, isLastPage, pages.length),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: DesignTokens.surface,
            ),
            padding: const EdgeInsets.all(40),
            child: Image.asset(
              page.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 60),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: DesignTokens.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
      OnboardingProvider provider, bool isLastPage, int totalPages) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: provider.currentPage == index ? 24 : 6,
                decoration: BoxDecoration(
                  color: provider.currentPage == index
                      ? DesignTokens.primary
                      : DesignTokens.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: isLastPage ? "Get Started" : "Continue",
            onPressed: () async {
              if (isLastPage) {
                _finishOnboarding(provider);
              } else {
                await CommonOnTap.openUrl();
                await Future.delayed(const Duration(milliseconds: 200));
                if (!context.mounted) return;
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


