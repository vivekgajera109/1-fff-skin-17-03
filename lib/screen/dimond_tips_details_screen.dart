import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (RemoteConfigService.isAdsShow) ...[
                    const BanerAdsScreen(),
                    const SizedBox(height: 32),
                  ],
                  SimpleCard(
                    color: Colors.white,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: DesignTokens.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "PRO INSIGHT",
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: DesignTokens.secondary,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.bookmark_outline_rounded, color: DesignTokens.textSecondary, size: 20),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          item.title,
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: DesignTokens.textPrimary,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: DesignTokens.divider, height: 1),
                        const SizedBox(height: 24),
                        Text(
                          item.subTitle ?? "Strategy details are currently being updated with the latest in-game meta changes. Check back soon for the full guide and tactical analysis.",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: DesignTokens.textSecondary,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (RemoteConfigService.isAdsShow) ...[
                    const SizedBox(height: 32),
                    const NativeAdsScreen(),
                  ],
                  const SizedBox(height: 48),
                  PrimaryButton(
                    text: 'Acknowledge Strategy',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
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
                  Icons.menu_book_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Strategy Guide",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



