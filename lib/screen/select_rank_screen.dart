import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
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
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "League RANK",
                expandedHeight: 240,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    top: -10,
                    child: Opacity(
                      opacity: 0.1,
                      child: Hero(
                        tag: 'character_select_${model.title}',
                        child: model.image != null
                            ? Image.asset(model.image!,
                                height: 300, fit: BoxFit.contain)
                            : Icon(Icons.military_tech_rounded,
                                size: 200, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: GradientHeader(title: 'TARGET_DIVISION', fontSize: 13),
                ),
              ),

              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final rankImages = provider.selectRankImage;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildRankCard(context, rankImages[index], index),
                        childCount: rankImages.length,
                      ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: NativeAdsScreen(),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
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
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.shield_rounded,
                size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildRankCard(BuildContext context, String image, int index) {
    final accents = [
      DesignTokens.primary,
      DesignTokens.secondary,
      const Color(0xFFFFD700),
      DesignTokens.highlight,
    ];
    final accent = accents[index % accents.length];

    return PremiumDashboardCard(
      onTap: () => _handleSelection(context),
      color: accent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: GlowContainer(
                  glowColor: accent,
                  child: Hero(
                    tag: 'rank_img_$index',
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accent.withOpacity(0.3), width: 1.5),
              ),
              child: Center(
                child: Text(
                  "SELECT",
                  style: GoogleFonts.outfit(
                    color: accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ClaimScreen(model: model)));
  }
}
