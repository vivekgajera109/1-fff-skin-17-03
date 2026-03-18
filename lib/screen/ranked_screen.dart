import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import 'level_id_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class RankedScreen extends StatelessWidget {
  final HomeItemModel model;

  const RankedScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final ranks = provider.ranked;
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
                        "Rank Classification",
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
                      final rank = ranks[index];
                      bool showNativeAd = RemoteConfigService.isAdsShow && (index != 0 && index % 4 == 0);

                      return Column(
                        children: [
                          _buildRankItem(context, rank, index),
                          if (showNativeAd) ...[
                            const SizedBox(height: 24),
                            const NativeAdsScreen(),
                            const SizedBox(height: 24),
                          ] else
                            const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: ranks.length,
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
                  Icons.military_tech_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Current Rank",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRankItem(BuildContext context, String rank, int index) {
    final color = _getRankColor(index);

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
              child: Icon(Icons.shield_rounded, color: color, size: 28),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rank,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Division Proficiency Stage ${index + 1}",
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => LevelIdScreen(model: model)));
  }

  Color _getRankColor(int index) {
    const colors = [
      Color(0xFF6B7280), // Gray
      Color(0xFF4F46E5), // Indigo
      Color(0xFF10B981), // Emerald
      Color(0xFFF59E0B), // Amber
      Color(0xFFEF4444), // Red
      Color(0xFF8B5CF6), // Violet
      Color(0xFFEC4899), // Pink
    ];
    return colors[index % colors.length];
  }
}



