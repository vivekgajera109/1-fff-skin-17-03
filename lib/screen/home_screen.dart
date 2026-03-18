import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
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
    return PageWrapper(
      bottomNavigationBar: _buildBottomNav(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildWelcomeHeader(),
                const SizedBox(height: 32),
                const GradientHeader(
                  title: "Premium Utilities",
                  fontSize: 14,
                ),
                const SizedBox(height: 20),
                _buildMainGrid(),
                if (RemoteConfigService.isAdsShow) ...[
                  const SizedBox(height: 32),
                  const NativeAdsScreen(),
                ],
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          "Skin Master Pro",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: DesignTokens.textPrimary,
          ),
        ),
        background: Stack(
          children: [
            Positioned(
              right: -30,
              top: -20,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignTokens.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _navigate(const SettingScreen()),
          icon: const Icon(Icons.settings_outlined,
              color: DesignTokens.textSecondary),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildWelcomeHeader() {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: DesignTokens.radiusXL,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back,",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "ELITE COMMANDER",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DesignTokens.primary.withOpacity(0.3)),
            ),
            child: const Icon(Icons.workspace_premium_rounded,
                color: DesignTokens.primary, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildMainGrid() {
    final List<_GridItem> items = [
      _GridItem("Elite Skins", "Exclusive Outfits", "assets/image/Leon.png",
          DesignTokens.primary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Elite Skins",
            characters: provider.characters,
            isSquared: false));
      }),
      _GridItem("Pro Weapons", "Legendary Skins",
          "assets/image/weapons/ak47.png", DesignTokens.secondary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Pro Weapons",
            characters: provider.weapons,
            isSquared: true));
      }),
      _GridItem("Rare Bundles", "Limited Rewards", "assets/image/bundles.png",
          const Color(0xFF6C5CE7), () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(
            appBarTitle: "Rare Bundles",
            characters: provider.bundles,
            isSquared: false));
      }),
      _GridItem("Claim Center", "Unlock Now", "assets/image/diamond_box.png",
          DesignTokens.primary, () {
        _navigate(ClaimScreen(model: _defaultModel));
      }),
      _GridItem("Rank Push", "Live Stats", "assets/image/rank/heroic.png",
          DesignTokens.secondary, () {
        _navigate(SelectRankScreen(model: _defaultModel));
      }),
      _GridItem("ID Styles", "Custom Nicks",
          "assets/image/dimond_characters.png", const Color(0xFF6C5CE7), () {
        _navigate(NickNameScreen(model: _defaultModel));
      }),
    ];

    return Column(
      children: items.map((item) => _buildListItem(item)).toList(),
    );
  }

  Widget _buildListItem(_GridItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PremiumCard(
        onTap: item.onTap,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusL),
                  border: Border.all(color: item.color.withOpacity(0.12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusL),
                  child: Hero(
                    tag: 'home_${item.title}',
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        _getIconForItem(item.title),
                        color: item.color,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: DesignTokens.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_right_rounded,
                    color: item.color, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForItem(String title) {
    if (title.contains("Skins")) return Icons.checkroom_rounded;
    if (title.contains("Weapons")) return Icons.sports_kabaddi_rounded;
    if (title.contains("Bundles")) return Icons.inventory_2_rounded;
    if (title.contains("Claim")) return Icons.redeem_rounded;
    if (title.contains("Rank")) return Icons.military_tech_rounded;
    return Icons.badge_rounded;
  }

  Widget _buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (RemoteConfigService.isAdsShow) const BanerAdsScreen(),
        NavigationBar(
          height: 70,
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) {
            setState(() => _currentIndex = idx);
            if (idx == 1) _navigate(const DimondTips());
            if (idx == 2) _navigate(const SettingScreen());
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined, size: 24),
              selectedIcon: Icon(Icons.grid_view_rounded,
                  color: DesignTokens.primary, size: 24),
              label: "Explore",
            ),
            NavigationDestination(
              icon: Icon(Icons.diamond_outlined, size: 24),
              selectedIcon: Icon(Icons.diamond_rounded,
                  color: DesignTokens.primary, size: 24),
              label: "Diamonds",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, size: 24),
              selectedIcon: Icon(Icons.settings_rounded,
                  color: DesignTokens.primary, size: 24),
              label: "Settings",
            ),
          ],
        ),
      ],
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
