import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
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
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (RemoteConfigService.isAdsShow) ...[
                  const BanerAdsScreen(),
                  const SizedBox(height: 32),
                ],
                _buildSuccessAssetModule(),
                const SizedBox(height: 32),
                _buildActionTerminal(context),
                if (RemoteConfigService.isAdsShow) ...[
                  const SizedBox(height: 32),
                  const NativeAdsScreen(),
                ],
                const SizedBox(height: 60),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        "FINAL DEPLOYMENT",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: DesignTokens.textPrimary,
          letterSpacing: 2.5,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSuccessAssetModule() {
    return CyberFrameCard(
      accentColor: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            // Luxury Image Frame
            Center(
              child: CyberImageFrame(
                imagePath: model.image,
                accentColor: DesignTokens.secondary,
                height: 220,
              ),
            ),
            const SizedBox(height: 40),
            // Success Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: DesignTokens.secondary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border:
                    Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_rounded,
                      color: DesignTokens.secondary, size: 14),
                  const SizedBox(width: 8),
                  Text(
                    "SYNC SUCCESSFUL",
                    style: GoogleFonts.inter(
                      color: DesignTokens.secondary,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              model.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Verification for ${model.title} is complete. Global fragment synchronization has reached 100%. Ready for local machine deployment.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: DesignTokens.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTerminal(BuildContext context) {
    return CyberFrameCard(
      accentColor: DesignTokens.primary,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bolt_rounded,
                    color: DesignTokens.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  "EXECUTION PHASE",
                  style: GoogleFonts.inter(
                    color: DesignTokens.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Initialize final handshake protocol to hard-link $model.title with your secure grid identity.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: DesignTokens.textSecondary,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            CyberButton(
              text: "Finalize Deployment",
              onPressed: () => _onCommit(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCommit(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialog(
        title: model.title,
        imagePath: model.image,
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final String title;
  final String? imagePath;
  const _SuccessDialog({required this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: CyberFrameCard(
        accentColor: DesignTokens.primary,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Asset Verification Header
                if (imagePath != null)
                  CyberImageFrame(
                    imagePath: imagePath!,
                    accentColor: DesignTokens.primary,
                    height: 180,
                  ),
                const SizedBox(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                    "HANDSHAKE COMPLETE",
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: DesignTokens.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Asset linkage confirmed. Deployment to your secure game profile is now authorized. Please restart the core game engine to apply changes.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: DesignTokens.textSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                CyberButton(
                  text: "Return to Home",
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
      ),
    );
  }
}
