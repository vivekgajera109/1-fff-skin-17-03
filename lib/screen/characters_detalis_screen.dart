import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'analysis_preparation_screen.dart';

class CharactersDetalisScreen extends StatelessWidget {
  final HomeItemModel characters;
  final bool isSquared;

  const CharactersDetalisScreen({
    super.key,
    required this.characters,
    this.isSquared = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: DesignTokens.surface,
                child: Center(
                  child: Hero(
                    tag: 'character_${characters.title}',
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: characters.image != null 
                        ? Image.asset(characters.image!, fit: BoxFit.contain)
                        : const Icon(Icons.inventory_2_outlined, size: 80, color: DesignTokens.primary),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: DesignTokens.spacing32),

                  if (RemoteConfigService.isAdsShow) ...[
                    const BanerAdsScreen(),
                    const SizedBox(height: DesignTokens.spacing32),
                  ],

                  _buildStatsRow(),
                  const SizedBox(height: DesignTokens.spacing32),

                  if (RemoteConfigService.isAdsShow) ...[
                    const NativeAdsScreen(),
                    const SizedBox(height: DesignTokens.spacing32),
                  ],

                  _buildActionPanel(context),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "PREMIUM CONTENT",
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: DesignTokens.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spacing16),
        Text(
          characters.title,
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing12),
        Text(
          characters.description ??
              "This exclusive content has been optimized for your profile. Complete the final setup to access and enjoy these features in your game.",
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: DesignTokens.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatBox("MOD", "PRO", DesignTokens.primary),
        const SizedBox(width: 12),
        _buildStatBox("SYNC", "100%", DesignTokens.secondary),
        const SizedBox(width: 12),
        _buildStatBox("RARITY", "HIGH", DesignTokens.accent),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Expanded(
      child: SimpleCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: DesignTokens.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return SimpleCard(
      child: Column(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: DesignTokens.primary, size: 32),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            "Ready to Deploy",
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Begin the final preparation phase",
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing24),
          PrimaryButton(
            text: "Start Preparing",
            onPressed: () => _onDeploy(context),
          ),
        ],
      ),
    );
  }

  Future<void> _onDeploy(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AnalysisPreparationScreen(model: characters)));
  }
}




