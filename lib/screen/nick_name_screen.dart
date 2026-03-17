import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: const Text("Account Verification"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: DesignTokens.spacing32),
            Text(
              "Account Details",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            _buildInputSection(),
            const SizedBox(height: DesignTokens.spacing32),
            if (RemoteConfigService.isAdsShow) ...[
              const NativeAdsScreen(),
              const SizedBox(height: DesignTokens.spacing32),
            ],
            PrimaryButton(
              text: "Verify & Proceed",
              onPressed: () => _onProceed(context),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return SimpleCard(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusM),
            ),
            child: Center(
              child: Hero(
                tag: 'character_${model.title}',
                child: model.image != null 
                    ? Image.asset(model.image!, height: 40, fit: BoxFit.contain)
                    : const Icon(Icons.person_outline_rounded, size: 30, color: DesignTokens.primary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                Text(
                  "Selected Item Ready",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: DesignTokens.surface,
            borderRadius: BorderRadius.circular(DesignTokens.radiusL),
            border: Border.all(color: DesignTokens.border),
          ),
          child: TextField(
            controller: _controller,
            style: GoogleFonts.outfit(
              color: DesignTokens.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "Enter your Game UID",
              hintStyle: GoogleFonts.outfit(
                color: DesignTokens.textSecondary.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.tag_rounded, color: DesignTokens.primary, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            "Please provide your unique gaming ID to correctly sync the item to your account.",
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onProceed(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RankedScreen(model: model)));
  }
}



