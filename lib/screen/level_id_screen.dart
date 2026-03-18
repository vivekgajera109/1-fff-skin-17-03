import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'select_rank_screen.dart';

class LevelIdScreen extends StatelessWidget {
  final HomeItemModel model;

  const LevelIdScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final levels = provider.levelId;
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
                        "Experience Milestone",
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
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final level = levels[index];
                      bool showNativeAd = RemoteConfigService.isAdsShow && (index != 0 && index % 4 == 0);

                      return Column(
                        children: [
                          _buildLevelCard(context, level, index),
                          if (showNativeAd) ...[
                            const SizedBox(height: 24),
                            const NativeAdsScreen(),
                            const SizedBox(height: 24),
                          ] else
                            const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: levels.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          );
        },
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
        onPressed: () => Navigator.pop(context),
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
                  Icons.signal_cellular_alt_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Account Level",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String level, int index) {
    final color = _getLevelColor(index);

    return SimpleCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                level,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: color,
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
                  "Level Range $level",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Operational Data Authenticated",
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: DesignTokens.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chevron_right_rounded, color: DesignTokens.textSecondary.withOpacity(0.5), size: 18),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => SelectRankScreen(model: model)));
  }

  Color _getLevelColor(int index) {
    final palette = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      const Color(0xFF10B981),
      const Color(0xFF8B5CF6),
    ];
    return palette[index % palette.length];
  }
}



