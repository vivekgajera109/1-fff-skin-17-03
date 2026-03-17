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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Skin Pro Tools",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: DesignTokens.textPrimary,
              ),
            ),
            Text(
              "Your ultimate companion",
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: DesignTokens.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _navigate(const SettingScreen()),
            icon: const Icon(Icons.settings_outlined, color: DesignTokens.textSecondary),
          ),
          const SizedBox(width: 8),
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
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.bolt_outlined), selectedIcon: Icon(Icons.bolt), label: "Diamonds"),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Discover Features",
              subtitle: "Select a tool to get started",
            ),
            const SizedBox(height: DesignTokens.spacing24),
            _buildMainGrid(),
            if (RemoteConfigService.isAdsShow) ...[
              const SizedBox(height: DesignTokens.spacing32),
              const NativeAdsScreen(),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMainGrid() {
    final List<_GridItem> items = [
      _GridItem("Characters", "Elite Squad", Icons.person_search_rounded, DesignTokens.primary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(appBarTitle: "Characters", characters: provider.characters, isSquared: false));
      }),
      _GridItem("Weapons", "Pro Armory", Icons.military_tech_rounded, DesignTokens.secondary, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(appBarTitle: "Pro Weapons", characters: provider.weapons, isSquared: true));
      }),
      _GridItem("Bundles", "Rare Vault", Icons.inventory_2_outlined, DesignTokens.accent, () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        _navigate(CharactersScreen(appBarTitle: "Legendary Bundles", characters: provider.bundles, isSquared: false));
      }),
      _GridItem("Rewards", "Claim Center", Icons.card_giftcard_rounded, DesignTokens.primary, () {
        _navigate(ClaimScreen(model: _defaultModel));
      }),
      _GridItem("Rank Tools", "Combat Stats", Icons.trending_up_rounded, DesignTokens.secondary, () {
        _navigate(SelectRankScreen(model: _defaultModel));
      }),
      _GridItem("ID Forge", "Nickname Tool", Icons.badge_outlined, DesignTokens.accent, () {
        _navigate(NickNameScreen(model: _defaultModel));
      }),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return SimpleCard(
          onTap: item.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignTokens.textPrimary,
                ),
              ),
              Text(
                item.subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
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
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _GridItem(this.title, this.subtitle, this.icon, this.color, this.onTap);
}





