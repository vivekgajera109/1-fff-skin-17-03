import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
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
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final tips = provider.dimondTips;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(28, 40, 28, 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const Expanded(
                        child: GradientHeader(
                            title: "STRATEGIC INTEL", fontSize: 13),
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
                        "${tips.length} TIPS LOADED",
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
              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(28, 24, 28, 0),
                    child: BanerAdsScreen(),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tip = tips[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _buildUniqueTipCard(context, tip, index),
                      );
                    },
                    childCount: tips.length,
                  ),
                ),
              ),
              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                    child: NativeAdsScreen(),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
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
        "INTEL TERMINAL",
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

  Widget _buildUniqueTipCard(BuildContext context, dynamic tip, int index) {
    final accentColor =
        index % 2 == 0 ? DesignTokens.primary : DesignTokens.secondary;
    final isRotatedLeft = index % 2 == 0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await CommonOnTap.openUrl();
          await Future.delayed(const Duration(milliseconds: 200));
          if (!context.mounted) return;
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
        },
        child: Transform.rotate(
          angle: isRotatedLeft ? -0.01 : 0.01,
          child: CyberFrameCard(
            accentColor: accentColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  // Intel Icon Hub
                  Container(
                    width: 50,
                    height: 50,
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
                    child: Icon(Icons.psychology_rounded,
                        color: accentColor, size: 26),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip.title.toString().toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "STRATEGIC PROTOCOL LOADED",
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
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        color: accentColor, size: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
