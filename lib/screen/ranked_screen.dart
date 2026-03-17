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
      appBar: AppBar(
        title: const Text("Select Rank"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final ranks = provider.ranked;
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
                        "Rank Profile",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please select your current gaming rank to finalize the optimization process.",
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
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final rank = ranks[index];
                      bool showNativeAd = RemoteConfigService.isAdsShow &&
                          (index != 0 && index % 4 == 0);
                      
                      return Column(
                        children: [
                          _buildRankItem(context, rank, index),
                          if (showNativeAd) ...[
                            const SizedBox(height: 16),
                            const NativeAdsScreen(),
                            const SizedBox(height: 16),
                          ] else
                            const SizedBox(height: 12),
                        ],
                      );
                    },
                    childCount: ranks.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRankItem(BuildContext context, String rank, int index) {
    final color = _getRankColor(index);
    
    return SimpleCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.stars_rounded, color: color, size: 24),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                Text(
                  "Division Level ${index + 1}",
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

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => LevelIdScreen(model: model)));
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



