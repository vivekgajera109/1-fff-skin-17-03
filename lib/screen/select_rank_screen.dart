import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import 'claim_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class SelectRankScreen extends StatelessWidget {
  final HomeItemModel model;

  const SelectRankScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final rankImages = provider.selectRankImage;
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
                        child: GradientHeader(title: "AMBITION TARGET", fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: DesignTokens.primary,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: DesignTokens.primary.withOpacity(0.5), blurRadius: 8)],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${rankImages.length} TIERS DETECTED",
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.82,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final image = rankImages[index];
                       // Show Ad every 4th item (if needed as a placeholder or layout check)
                      return _buildUniqueRankCard(context, image, index);
                    },
                    childCount: rankImages.length,
                  ),
                ),
              ),
              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 8, 24, 32),
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

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        "RANK VAULT",
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

  Widget _buildUniqueRankCard(BuildContext context, String image, int index) {
    final palette = [
      DesignTokens.primary,
      DesignTokens.secondary,
      const Color(0xFF6C5CE7),
      const Color(0xFFF59E0B),
    ];
    final accentColor = palette[index % palette.length];
    final isRotatedLeft = index % 2 == 0;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleSelection(context),
        child: Transform.rotate(
          angle: isRotatedLeft ? -0.02 : 0.02,
          child: CyberFrameCard(
            accentColor: accentColor,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   // Image Frame with Inner Decor
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.05),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isRotatedLeft ? 16 : 4),
                          bottomRight: Radius.circular(isRotatedLeft ? 4 : 16),
                          topRight: const Radius.circular(10),
                          bottomLeft: const Radius.circular(10),
                        ),
                        border: Border.all(color: accentColor.withOpacity(0.1)),
                      ),
                      child: Center(
                        child: Hero(
                          tag: 'rank_img_$index',
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(image, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tech Label Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "VALD: 1.0",
                        style: GoogleFonts.inter(
                          fontSize: 7,
                          fontWeight: FontWeight.w900,
                          color: accentColor.withOpacity(0.5),
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "LINK",
                          style: GoogleFonts.inter(
                            fontSize: 7,
                            fontWeight: FontWeight.w900,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => ClaimScreen(model: model)));
  }
}
