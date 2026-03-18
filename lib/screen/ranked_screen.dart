import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
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
    return PageWrapper(
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final ranks = provider.ranked;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(context),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(28, 40, 28, 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const Expanded(
                        child: GradientHeader(
                            title: "RANK CLASSIFICATION", fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: DesignTokens.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: DesignTokens.primary.withOpacity(0.5),
                                blurRadius: 8)
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${ranks.length} TIERS DETECTED",
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textSecondary,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final rank = ranks[index];
                      // Show Ad every 4th item
                      if (RemoteConfigService.isAdsShow &&
                          index != 0 &&
                          index % 4 == 0) {
                        return const Center(child: NativeAdsScreen());
                      }
                      return _buildUniqueRankCard(context, rank, index);
                    },
                    childCount: ranks.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2.8,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        "RANK MATRIX",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: DesignTokens.textPrimary,
          letterSpacing: 2.5,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildUniqueRankCard(BuildContext context, String rank, int index) {
    final accentColor = _getRankColor(index);
    final isRotatedLeft = index % 2 == 0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleSelection(context),
        child: Transform.rotate(
          angle: isRotatedLeft ? -0.01 : 0.01,
          child: CyberFrameCard(
            accentColor: accentColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  // Rank Preview Icon
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isRotatedLeft ? 16 : 4),
                        bottomRight: Radius.circular(isRotatedLeft ? 4 : 16),
                        topRight: const Radius.circular(10),
                        bottomLeft: const Radius.circular(10),
                      ),
                      border: Border.all(color: accentColor.withOpacity(0.2)),
                    ),
                    child: Icon(Icons.military_tech_rounded,
                        color: accentColor, size: 32),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rank.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "DIVISION TIER ${index + 1}",
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: DesignTokens.textSecondary,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                        color: accentColor, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
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
      Color(0xFF94A3B8), // Slate
      Color(0xFF6366F1), // Indigo
      Color(0xFF10B981), // Emerald
      Color(0xFFF59E0B), // Amber
      Color(0xFFEF4444), // Red
      Color(0xFF8B5CF6), // Violet
      Color(0xFFEC4899), // Pink
    ];
    return colors[index % colors.length];
  }
}
