import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import 'dimond_tips_details_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class DimondTips extends StatelessWidget {
  const DimondTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: const Text("Gaming Tips"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final tips = provider.dimondTips;
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
                        "Pro Insights",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Exclusive strategies and tips to improve your gaming performance and experience.",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: BanerAdsScreen(),
                  ),
                ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tip = tips[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
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
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
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

  Widget _buildTipCard(BuildContext context, dynamic tip, int index) {
    return SimpleCard(
      onTap: () async {
        await CommonOnTap.openUrl();
        await Future.delayed(const Duration(milliseconds: 200));
        if (!context.mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
      },
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.secondary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Updated Strategy Guide",
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: DesignTokens.textSecondary.withOpacity(0.3), size: 14),
        ],
      ),
    );
  }
}



