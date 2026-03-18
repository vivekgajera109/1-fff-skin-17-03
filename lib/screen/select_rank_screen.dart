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
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        body: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            final rankImages = provider.selectRankImage;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(context),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: DesignTokens.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Target Ambition",
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: DesignTokens.textPrimary,
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
                      childAspectRatio: 0.82,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildRankCard(context, rankImages[index], index),
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
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            );
          },
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
                  Icons.stars_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Target Rank",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color.withOpacity(0.04),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(DesignTokens.radiusL)),
              ),
              child: Hero(
                tag: 'rank_img_$index',
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(DesignTokens.radiusL)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SELECT",
                  style: GoogleFonts.outfit(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 6),
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => ClaimScreen(model: model)));
  }
}
