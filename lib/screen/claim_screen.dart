import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import 'home_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class ClaimScreen extends StatelessWidget {
  final HomeItemModel model;

  const ClaimScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "Synchronization SUCCESS",
                expandedHeight: 260,
                accentColor: DesignTokens.highlight,
                backgroundExtras: [
                  Positioned(
                    right: -60,
                    bottom: -40,
                    child: Opacity(
                      opacity: 0.12,
                      child: Hero(
                        tag: 'character_claim_${model.title}',
                        child: model.image != null 
                            ? Image.asset(model.image!, height: 350, fit: BoxFit.contain)
                            : Icon(Icons.verified_user_rounded, size: 300, color: DesignTokens.highlight),
                      ),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      if (RemoteConfigService.isAdsShow) ...[
                        const BanerAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      _buildSuccessPanel(),
                      const SizedBox(height: 32),
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      _buildActionPanel(context),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 450,
          right: -50,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.stream_rounded, size: 400, color: DesignTokens.highlight),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessPanel() {
    return PremiumDashboardCard(
      color: DesignTokens.highlight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            GlowContainer(
              glowColor: DesignTokens.highlight,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: DesignTokens.highlight.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: DesignTokens.highlight.withOpacity(0.4), width: 1.5),
                ),
                child: const Icon(Icons.check_rounded, color: DesignTokens.highlight, size: 56),
              ),
            ),
            const SizedBox(height: 36),
            Text(
              "NEURAL LINK OPTIMIZED",
              style: GoogleFonts.outfit(
                color: DesignTokens.highlight,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              model.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              height: 2,
              width: 60,
              color: DesignTokens.highlight.withOpacity(0.3),
            ),
            const SizedBox(height: 32),
            Text(
              "Protocol sync for ${model.title} established. All assets have been compiled and staged for local deployment.",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return PremiumDashboardCard(
      color: DesignTokens.primary,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.terminal_rounded, color: DesignTokens.primary, size: 20),
                const SizedBox(width: 12),
                Text(
                  "FINAL_COMMIT",
                  style: GoogleFonts.outfit(
                    color: DesignTokens.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Execute the final handshake to synchronize these assets with your local terminal.",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 36),
            CyberButton(
              text: "COMMIT SYNC",
              onPressed: () => _onCommit(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCommit(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) => _SyncSuccessDialog(title: model.title),
      transitionDuration: const Duration(milliseconds: 600),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        );
      },
    );
  }
}

class _SyncSuccessDialog extends StatelessWidget {
  final String title;
  const _SyncSuccessDialog({required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: PremiumDashboardCard(
        color: DesignTokens.primary,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlowContainer(
                glowColor: DesignTokens.primary,
                child: const Icon(Icons.offline_pin_rounded, size: 80, color: DesignTokens.primary),
              ),
              const SizedBox(height: 32),
              Text(
                "SYNCHRONIZED",
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.textPrimary,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Access granted for "$title". Please restart the application to finalize the neural bridge.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: DesignTokens.textSecondary, 
                  fontSize: 15, 
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),
              CyberButton(
                text: "TERMINATE LINK",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



