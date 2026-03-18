import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
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
    return PageWrapper(
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final levels = provider.levelId;
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
                            title: "XP MILESTONES", fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: DesignTokens.secondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: DesignTokens.secondary.withOpacity(0.5),
                                blurRadius: 8)
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${levels.length} PHASES DETECTED",
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
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final level = levels[index];
                      // Show Ad every 4th item
                      if (RemoteConfigService.isAdsShow &&
                          index != 0 &&
                          index % 4 == 0) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: NativeAdsScreen(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _buildUniqueLevelCard(context, level, index),
                      );
                    },
                    childCount: levels.length,
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
        "XP TERMINAL",
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

  Widget _buildUniqueLevelCard(BuildContext context, String level, int index) {
    final accentColor = _getLevelColor(index);
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
                  // Level Icon Hub
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
                    child: Center(
                      child: Text(
                        level.split('-').last,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RANGE: $level".toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "MILITARY XP LOG AUTHENTICATED",
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: DesignTokens.textSecondary,
                            letterSpacing: 1,
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
                    child:
                        Icon(Icons.bolt_rounded, color: accentColor, size: 16),
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
        MaterialPageRoute(builder: (_) => SelectRankScreen(model: model)));
  }

  Color _getLevelColor(int index) {
    const palette = [
      DesignTokens.primary,
      DesignTokens.secondary,
      Color(0xFF6C5CE7),
      Color(0xFF10B981),
      Color(0xFF8B5CF6),
    ];
    return palette[index % palette.length];
  }
}
