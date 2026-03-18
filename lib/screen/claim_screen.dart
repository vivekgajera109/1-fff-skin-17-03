import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: Text(model.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          children: [
            if (RemoteConfigService.isAdsShow) ...[
              const BanerAdsScreen(),
              const SizedBox(height: DesignTokens.spacing24),
            ],
            _buildSuccessPanel(),
            const SizedBox(height: DesignTokens.spacing24),
            _buildActionPanel(context),
            if (RemoteConfigService.isAdsShow) ...[
              const SizedBox(height: DesignTokens.spacing24),
              const NativeAdsScreen(),
            ],
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessPanel() {
    return SimpleCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_rounded, color: DesignTokens.secondary, size: 64),
          ),
          const SizedBox(height: DesignTokens.spacing24),
          Text(
            "Successful",
            style: GoogleFonts.outfit(
              color: DesignTokens.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            "Your request for ${model.title} has been processed successfully. You can now proceed to the final step.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return SimpleCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline_rounded, color: DesignTokens.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                "Final Step",
                style: GoogleFonts.outfit(
                  color: DesignTokens.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Text(
            "Complete the final synchronization to enable these features in your game profile.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing24),
          PrimaryButton(
            text: "Complete Now",
            onPressed: () => _onCommit(context),
          ),
        ],
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
      builder: (_) => _SuccessDialog(title: model.title),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final String title;
  const _SuccessDialog({required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DesignTokens.radiusL)),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars_rounded, size: 64, color: DesignTokens.accent),
            const SizedBox(height: DesignTokens.spacing20),
            Text(
              "All Set!",
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Text(
              'Features for "$title" are now unlocked. Please restart your app to see the changes.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary, 
                fontSize: 14, 
                height: 1.5,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),
            PrimaryButton(
              text: "Finish",
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
    );
  }
}



