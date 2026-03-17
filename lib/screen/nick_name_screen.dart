import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import 'ranked_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class NickNameScreen extends StatelessWidget {
  final HomeItemModel model;
  final TextEditingController _controller = TextEditingController();

  NickNameScreen({
    super.key,
    required this.model,
  });

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
                title: "Identity LINK",
                expandedHeight: 220,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.fingerprint_rounded, size: 220, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      _buildSyncPanel(),
                      const SizedBox(height: 48),
                      const GradientHeader(title: 'NEURAL_INPUT', fontSize: 13),
                      const SizedBox(height: 24),
                      _buildInputPanel(context),
                      const SizedBox(height: 32),
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      CyberButton(
                        text: "ESTABLISH LINK",
                        onPressed: () => _onProceed(context),
                      ),
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
          top: 400,
          left: -60,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.badge_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncPanel() {
    return PremiumDashboardCard(
      color: DesignTokens.primary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            GlowContainer(
              glowColor: DesignTokens.primary,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.primary.withOpacity(0.1),
                  border: Border.all(color: DesignTokens.primary.withOpacity(0.3), width: 1.5),
                ),
                child: Center(
                  child: Hero(
                    tag: 'character_${model.title}',
                    child: model.image != null 
                        ? Image.asset(model.image!, height: 50, fit: BoxFit.contain)
                        : Icon(Icons.person_rounded, size: 36, color: DesignTokens.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STAGED ASSET",
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.title.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.textPrimary,
                    ),
                  ),
                  Text(
                    "Ready for neural binding",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.verified_user_rounded, color: DesignTokens.primary.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputPanel(BuildContext context) {
    return PremiumDashboardCard(
      color: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GlowContainer(
                  glowColor: DesignTokens.secondary,
                  child: Icon(Icons.terminal_rounded, color: DesignTokens.secondary, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  "TERMINAL_ACCESS",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
              ),
              child: TextField(
                controller: _controller,
                cursorColor: DesignTokens.secondary,
                style: GoogleFonts.outfit(
                  color: DesignTokens.textPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
                decoration: InputDecoration(
                  hintText: "PROVIDE GAMING UID",
                  hintStyle: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary.withOpacity(0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                  prefixIcon: Icon(Icons.grid_3x3_rounded, color: DesignTokens.secondary, size: 18),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: DesignTokens.secondary.withOpacity(0.5), size: 14),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "UID is required to establish a direct link between the neural bridge and your game profile.",
                    style: GoogleFonts.outfit(
                      color: DesignTokens.textSecondary,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onProceed(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RankedScreen(model: model)));
  }
}



