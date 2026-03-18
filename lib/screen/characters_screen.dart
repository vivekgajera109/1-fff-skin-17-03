import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'characters_detalis_screen.dart';

class CharactersScreen extends StatelessWidget {
  final List<HomeItemModel> characters;
  final String appBarTitle;
  final bool isSquared;

  const CharactersScreen({
    super.key,
    required this.characters,
    required this.appBarTitle,
    this.isSquared = true,
  });

  @override
  Widget build(BuildContext context) {
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context),
            if (RemoteConfigService.isAdsShow)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: BanerAdsScreen(),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      "${characters.length} items",
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ..._buildGridWithAds(context),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.06),
      forceElevated: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            color: DesignTokens.textPrimary, size: 20),
      ),
      title: Text(
        appBarTitle,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: DesignTokens.textPrimary,
        ),
      ),
      centerTitle: false,
    );
  }

  List<Widget> _buildGridWithAds(BuildContext context) {
    List<Widget> slivers = [];
    for (int i = 0; i < characters.length; i += 6) {
      int end = (i + 6 < characters.length) ? i + 6 : characters.length;
      final chunk = characters.sublist(i, end);
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(context, chunk[index]),
              childCount: chunk.length,
            ),
          ),
        ),
      );
      if (end < characters.length && RemoteConfigService.isAdsShow) {
        slivers.add(
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: NativeAdsScreen(),
            ),
          ),
        );
      }
    }
    return slivers;
  }

  Widget _buildCard(BuildContext context, HomeItemModel item) {
    final List<Color> cardBgColors = [
      const Color(0xFFEEF0FD), // soft indigo
      const Color(0xFFEAF7F2), // soft emerald
      const Color(0xFFFEF6E8), // soft amber
      const Color(0xFFF0EEFB), // soft purple
      const Color(0xFFE8F5F0), // soft teal
      const Color(0xFFFDF0EE), // soft rose
    ];
    final bgColor = cardBgColors[characters.indexOf(item) % cardBgColors.length];

    return GestureDetector(
      onTap: () => _openDetails(context, item, isSquared),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image fills the card
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
                child: Hero(
                  tag: 'character_${item.title}',
                  child: item.image != null
                      ? Image.asset(item.image!, fit: BoxFit.contain)
                      : const Icon(Icons.inventory_2_outlined,
                          color: DesignTokens.primary, size: 48),
                ),
              ),
              // Bottom gradient scrim
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.55),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: DesignTokens.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Premium",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDetails(
      BuildContext context, HomeItemModel character, bool isSquared) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CharactersDetalisScreen(characters: character, isSquared: isSquared),
      ),
    );
  }
}
