import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
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
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: appBarTitle,
                expandedHeight: 240,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(
                        Icons.psychology_rounded,
                        size: 250,
                        color: DesignTokens.primary,
                      ),
                    ),
                  ),
                ],
              ),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: BanerAdsScreen(),
                  ),
                ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: GradientHeader(
                          title: 'Neural Archive',
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: DesignTokens.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: DesignTokens.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          "${characters.length} NODES",
                          style: GoogleFonts.outfit(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.primary,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ..._buildGridWithAds(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 400,
          left: -100,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.grid_4x4_rounded, size: 450, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGridWithAds(BuildContext context) {
    List<Widget> slivers = [];
    for (int i = 0; i < characters.length; i += 4) {
      int end = (i + 4 < characters.length) ? i + 4 : characters.length;
      final chunk = characters.sublist(i, end);
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildCharacterCard(context, chunk[index], i + index),
              childCount: chunk.length,
            ),
          ),
        ),
      );
      if (end < characters.length && RemoteConfigService.isAdsShow) {
        slivers.add(
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: NativeAdsScreen(),
            ),
          ),
        );
      }
    }
    slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 120)));
    return slivers;
  }

  Widget _buildCharacterCard(
      BuildContext context, HomeItemModel item, int index) {
    final accents = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.highlight,
      DesignTokens.warning,
    ];
    final accent = accents[index % accents.length];

    return PremiumDashboardCard(
      onTap: () => _openDetails(context, item, isSquared),
      color: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.05,
                    child: Icon(Icons.circle_outlined, size: 120, color: accent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GlowContainer(
                    glowColor: accent,
                    blurRadius: 15,
                    child: Hero(
                      tag: 'character_${item.title}',
                      child: item.image != null 
                        ? Image.asset(item.image!, fit: BoxFit.contain)
                        : Icon(Icons.person, color: accent, size: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  item.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: accent, blurRadius: 4)
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "CLASS_S_ALPHA",
                      style: GoogleFonts.outfit(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openDetails(
      BuildContext context, HomeItemModel character, bool isSquared) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CharactersDetalisScreen(
                characters: character, isSquared: isSquared)));
  }
}


