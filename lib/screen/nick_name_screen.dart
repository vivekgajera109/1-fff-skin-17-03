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
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSyncAlert(),
                    const SizedBox(height: 32),
                    _buildHeader("Item Selection"),
                    const SizedBox(height: 16),
                    _buildInfoCard(),
                    const SizedBox(height: 40),
                    _buildHeader("Account Sync"),
                    const SizedBox(height: 16),
                    _buildInputSection(),
                    const SizedBox(height: 48),
                    if (RemoteConfigService.isAdsShow) ...[
                      const NativeAdsScreen(),
                      const SizedBox(height: 48),
                    ],
                    PrimaryButton(
                      text: "Synchronize Account",
                      onPressed: () => _onProceed(context),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110,
      pinned: true,
      elevation: 0,
      backgroundColor: DesignTokens.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: DesignTokens.primaryGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -10,
                child: Icon(
                  Icons.verified_user_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Synchronization",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: DesignTokens.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSyncAlert() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DesignTokens.secondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.security_rounded, color: DesignTokens.secondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Your information is stored locally and used only for synchronization.",
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: DesignTokens.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return SimpleCard(
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Hero(
                tag: 'character_${model.title}',
                child: model.image != null
                    ? Image.asset(model.image!, height: 45, fit: BoxFit.contain)
                    : const Icon(Icons.person_outline_rounded, size: 36, color: DesignTokens.primary),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Awaiting Validation",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: DesignTokens.primary,
                    fontWeight: FontWeight.w600,
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: DesignTokens.premiumShadow,
            border: Border.all(color: DesignTokens.border.withOpacity(0.5)),
          ),
          child: TextField(
            controller: _controller,
            style: GoogleFonts.outfit(
              color: DesignTokens.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: "Enter your Gaming ID",
              hintStyle: GoogleFonts.outfit(
                color: DesignTokens.textSecondary.withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: const Icon(Icons.fingerprint_rounded, color: DesignTokens.primary, size: 22),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Syncing requires your unique game identifier to ensure correctly linked delivery.",
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => RankedScreen(model: model)));
  }
}



