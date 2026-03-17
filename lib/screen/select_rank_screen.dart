import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import 'claim_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class SelectRankScreen extends StatelessWidget {
  final HomeItemModel model;

  const SelectRankScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: const Text("Target Rank"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final rankImages = provider.selectRankImage;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(DesignTokens.spacing24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Target Division",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Select your goal rank to start the account optimization process.",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildRankCard(context, rankImages[index], index),
                    childCount: rankImages.length,
                  ),
                ),
              ),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: NativeAdsScreen(),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRankCard(BuildContext context, String image, int index) {
    final palette = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      const Color(0xFFF59E0B),
    ];
    final color = palette[index % palette.length];

    return SimpleCard(
      onTap: () => _handleSelection(context),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(DesignTokens.radiusL)),
              ),
              child: Hero(
                tag: 'rank_img_$index',
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SELECT",
                  style: GoogleFonts.outfit(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios_rounded, color: color, size: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ClaimScreen(model: model)));
  }
}
