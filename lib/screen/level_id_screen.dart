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
      appBar: AppBar(
        title: const Text("Account Level"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final levels = provider.levelId;
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
                        "Experience Level",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Select your current in-game level to continue the synchronization process.",
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
                      final level = levels[index];
                      bool showNativeAd = RemoteConfigService.isAdsShow &&
                          (index != 0 && index % 4 == 0);
                      
                      return Column(
                        children: [
                          _buildLevelCard(context, level, index),
                          if (showNativeAd) ...[
                            const SizedBox(height: 16),
                            const NativeAdsScreen(),
                            const SizedBox(height: 16),
                          ] else
                            const SizedBox(height: 12),
                        ],
                      );
                    },
                    childCount: levels.length,
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

  Widget _buildLevelCard(BuildContext context, String level, int index) {
    final color = _getLevelColor(index);
    
    return SimpleCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                level,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                Text(
                  "Operational Profile Active",
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
        MaterialPageRoute(builder: (_) => SelectRankScreen(model: model)));
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



