import 'package:fff_skin_tools/widgets/premium_widgets.dart';
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
    return PageWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          if (RemoteConfigService.isAdsShow)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: BanerAdsScreen(),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const GradientHeader(title: "Collection", fontSize: 13),
                  const Spacer(),
                  Text(
                    "${characters.length} ITEMS",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: DesignTokens.textSecondary,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ..._buildGridWithAds(context),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        appBarTitle,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: DesignTokens.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  List<Widget> _buildGridWithAds(BuildContext context) {
    List<Widget> slivers = [];
    for (int i = 0; i < characters.length; i += 6) {
      int end = (i + 6 < characters.length) ? i + 6 : characters.length;
      final chunk = characters.sublist(i, end);
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 0.78,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isAlt = index % 2 != 0;
                return _buildUniqueCard(context, chunk[index], isAlt);
              },
              childCount: chunk.length,
            ),
          ),
        ),
      );
      if (end < characters.length && RemoteConfigService.isAdsShow) {
        slivers.add(
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 32, 20, 16),
              child: NativeAdsScreen(),
            ),
          ),
        );
      }
    }
    return slivers;
  }

  Widget _buildUniqueCard(BuildContext context, HomeItemModel item, bool isAlt) {
    final accentColor = _getAccentColor(item.title);
    return CyberFrameCard(
      accentColor: accentColor,
      onTap: () => _openDetails(context, item, isSquared),
      child: Stack(
        children: [
          // Dynamic Corner Badge
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: accentColor.withOpacity(0.4), width: 0.5),
              ),
              child: Text(
                "ID-${item.title.hashCode.toString().substring(0, 4)}",
                style: GoogleFonts.inter(
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, isAlt ? 40 : 24, 16, 16),
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: 'character_${item.title}',
                    child: Transform.rotate(
                      angle: isAlt ? 0.05 : -0.05,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: -10,
                            )
                          ],
                        ),
                        child: item.image != null
                            ? Image.asset(item.image!, fit: BoxFit.contain)
                            : const Icon(Icons.inventory_2_outlined,
                                color: DesignTokens.primary, size: 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  item.title.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _buildTechStatus(accentColor),
              ],
            ),
          ),
          
          // Hover Overlay (always visible slightly in mobile)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15)),
              ),
              child: Center(
                child: Icon(Icons.add_rounded, color: accentColor, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStatus(Color color) {
    return Container(
      width: double.infinity,
      height: 2,
      child: Stack(
        children: [
          Container(color: DesignTokens.border.withOpacity(0.2)),
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(color: color),
          ),
        ],
      ),
    );
  }

  Color _getAccentColor(String title) {
    if (title.contains("Skins")) return DesignTokens.primary;
    if (title.contains("Weapons")) return DesignTokens.secondary;
    return DesignTokens.primary;
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
