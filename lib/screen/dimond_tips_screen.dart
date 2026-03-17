import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import 'dimond_tips_details_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class DimondTips extends StatelessWidget {
  const DimondTips({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          _buildBackgroundElements(),

          Consumer<HomeProvider>(
            builder: (context, provider, _) {
              final tips = provider.dimondTips;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  CyberSliverAppBar(
                    title: "Expert ADVISORY",
                    expandedHeight: 220,
                    accentColor: DesignTokens.secondary,
                    backgroundExtras: [
                      Positioned(
                        right: -20,
                        top: 40,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(
                            Icons.diamond_rounded,
                            size: 200,
                            color: DesignTokens.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: GradientHeader(
                              title: 'PRO_INTEL',
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: DesignTokens.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
                            ),
                            child: Text(
                              "SYNCED_ARCHIVES: ${tips.length}",
                              style: GoogleFonts.outfit(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.secondary,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: BanerAdsScreen(),
                      ),
                    ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= tips.length) return null;
                          final tip = tips[index];
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildTipCard(context, tip, index),
                          );
                        },
                        childCount: tips.length,
                      ),
                    ),
                  ),

                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: NativeAdsScreen(),
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              );
            },
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
            child: Icon(Icons.psychology_rounded, size: 300, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(BuildContext context, dynamic tip, int index) {
    return PremiumDashboardCard(
      onTap: () async {
        await CommonOnTap.openUrl();
        await Future.delayed(const Duration(milliseconds: 400));
        if (!context.mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
      },
      color: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            GlowContainer(
              glowColor: DesignTokens.secondary,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: DesignTokens.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DesignTokens.secondary.withOpacity(0.3), width: 1.5),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}".padLeft(2, '0'),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.secondary,
                      fontSize: 18,
                    ),
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
                    tip.title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: DesignTokens.textPrimary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: DesignTokens.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "PRIORITY_PROTOCOL_ACTIVE",
                        style: GoogleFonts.outfit(
                          color: DesignTokens.secondary.withOpacity(0.6),
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: DesignTokens.secondary.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}



