import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/section_title.dart';
import '../provider/home_provider.dart';
import '../helper/analytics_service.dart';
import '../model/home_item_model.dart';
import 'characters_screen.dart';
import 'settings_screen.dart';
import 'dimond_tips_screen.dart';
import 'claim_screen.dart';
import 'nick_name_screen.dart';
import 'select_rank_screen.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'HomeScreen');
  }

  HomeItemModel get _defaultModel => HomeItemModel(
        title: "Tool Box",
        subTitle: "Utility Tools",
        image: null,
      );

  @override
  Widget build(BuildContext context) {
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeBanner(),
                    const SizedBox(height: 32),
                    const SectionTitle(
                      title: "Explore Utilities",
                      subtitle: "Select a module to proceed",
                    ),
                    const SizedBox(height: 20),
                    _buildMainGrid(),
                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 32),
                      const NativeAdsScreen(),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (RemoteConfigService.isAdsShow) const BanerAdsScreen(),
            NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (idx) {
                setState(() => _currentIndex = idx);
                if (idx == 1) _navigate(const DimondTips());
                if (idx == 2) _navigate(const SettingScreen());
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.bolt_outlined),
                    selectedIcon: Icon(Icons.bolt),
                    label: "Diamonds"),
                NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: "Profile"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: DesignTokens.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: DesignTokens.primaryGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.auto_awesome_mosaic_outlined,
                  size: 150,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          "Skin Master Pro",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _navigate(const SettingScreen()),
          icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildWelcomeBanner() {
    return SimpleCard(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.celebration_rounded,
                color: DesignTokens.primary, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Level Up Your Game",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                Text(
                  "Get exclusive tools and tips",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainGrid() {
    final List<_GridItem> items = [
      _GridItem("Elite Skins", "Premium Outfits", "assets/image/Leon.png",
          DesignTokens.primary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Elite Skins",
            characters: provider.characters,
            isSquared: false));
      }),
      _GridItem("Pro Weapons", "Legendary Skins", "assets/image/weapons/ak47.png",
          DesignTokens.secondary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Pro Weapons",
            characters: provider.weapons,
            isSquared: true));
      }),
      _GridItem("Rare Bundles", "Unbox Rewards", "assets/image/bundles.png",
          DesignTokens.accent, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Rare Bundles",
            characters: provider.bundles,
            isSquared: false));
      }),
      _GridItem("Claim Center", "Get Now", "assets/image/diamond_box.png",
          DesignTokens.primary, () {
        _navigate(ClaimScreen(model: _defaultModel));
      }),
      _GridItem("Rank Push", "Live Stats", "assets/image/rank/heroic.png",
          DesignTokens.secondary, () {
        _navigate(SelectRankScreen(model: _defaultModel));
      }),
      _GridItem("ID Styles", "Custom Nicknames", "assets/image/dimond_characters.png",
          DesignTokens.accent, () {
        _navigate(NickNameScreen(model: _defaultModel));
      }),
    ];

    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: GestureDetector(
            onTap: item.onTap,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: DesignTokens.surface,
                borderRadius: BorderRadius.circular(DesignTokens.radiusL),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                  const BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left accent bar
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [item.color, item.color.withOpacity(0.4)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(DesignTokens.radiusL),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Icon badge circle
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: DesignTokens.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.subtitle,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: DesignTokens.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow CTA
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: item.color,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _navigate(Widget screen) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

class _GridItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final VoidCallback onTap;

  _GridItem(this.title, this.subtitle, this.imagePath, this.color, this.onTap);
}
