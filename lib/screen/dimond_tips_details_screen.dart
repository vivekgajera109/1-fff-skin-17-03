import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../model/home_item_model.dart';

class DimondTipsDetalis extends StatelessWidget {
  final HomeItemModel item;

  const DimondTipsDetalis({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (RemoteConfigService.isAdsShow) ...[
                    const BanerAdsScreen(),
                    const SizedBox(height: 32),
                  ],
                  _buildUniqueContentCard(),
                  if (RemoteConfigService.isAdsShow) ...[
                    const SizedBox(height: 32),
                    const NativeAdsScreen(),
                  ],
                  const SizedBox(height: 48),
                  CyberButton(
                    text: 'Acknowledge Strategy',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "STRATEGY LOG",
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

  Widget _buildUniqueContentCard() {
    return CyberFrameCard(
      accentColor: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: DesignTokens.secondary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
                  ),
                  child: Text(
                    "TAC-001 / INSIGHT",
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.secondary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.security_rounded, color: DesignTokens.secondary, size: 20),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              item.title.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                height: 1.2,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                color: DesignTokens.secondary,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            const SizedBox(height: 32),
             Text(
              "DETAILED ANALYSIS:",
              style: GoogleFonts.inter(
                fontSize: 10,
                color: DesignTokens.secondary.withOpacity(0.8),
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.subTitle ?? "Strategy details are currently being updated with the latest in-game meta changes. Check back soon for the full guide and tactical analysis.",
              style: GoogleFonts.inter(
                fontSize: 15,
                color: DesignTokens.textSecondary,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 48),
            // Footer Info
            Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(color: DesignTokens.secondary, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(
                  "STATUS: VERIFIED ADVICE",
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



