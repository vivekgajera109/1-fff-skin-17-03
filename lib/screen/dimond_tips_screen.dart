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
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        body: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            final tips = provider.dimondTips;
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
                          "Strategic Insights",
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
                if (RemoteConfigService.isAdsShow)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
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
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
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
                  Icons.lightbulb_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Diamond Tips",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, dynamic tip, int index) {
    return SimpleCard(
      onTap: () async {
        await CommonOnTap.openUrl();
        await Future.delayed(const Duration(milliseconds: 200));
        if (!context.mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
      },
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${index + 1}",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: DesignTokens.primary,
                fontSize: 16,
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
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tip.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: DesignTokens.border),
        ],
      ),
    );
  }
}
