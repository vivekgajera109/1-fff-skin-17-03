import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../provider/home_provider.dart';
import '../helper/analytics_service.dart';
import '../model/home_item_model.dart';
import 'characters_screen.dart';
import 'settings_screen.dart';
import 'dimond_tips_screen.dart';
import 'claim_screen.dart';
import 'nick_name_screen.dart';
import 'select_rank_screen.dart';
import 'ranked_screen.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'HomeScreen');
  }

  // Create a default model for direct tool access from home
  HomeItemModel get _defaultModel => HomeItemModel(
    title: "Elite Command",
    subTitle: "System Tools",
    image: null,
  );

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      bottomNavigationBar: RemoteConfigService.isAdsShow
          ? const BanerAdsScreen()
          : null,
      child: Stack(
        children: [
          // Ambient background elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber App Bar
              CyberSliverAppBar(
                title: "Neural Interface",
                showBack: false,
                expandedHeight: 250,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  _buildAppBarOverlay(),
                ],
              ),

              // Top Section: Profile & Welcome
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: Row(
                    children: [
                      _buildProfileAvatar(),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "COMMANDER",
                                  style: GoogleFonts.outfit(
                                    color: DesignTokens.secondary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildStatusBadge(),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AGENT_V_09",
                              style: GoogleFonts.outfit(
                                color: DesignTokens.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GlowIconButton(
                        icon: Icons.settings_outlined,
                        color: DesignTokens.textSecondary,
                        onTap: () => _navigate(const SettingScreen()),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              // Middle Section: Horizontal Featured Tools
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GradientHeader(
                          title: "Featured Protocols",
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            _buildFeaturedCard(
                              "STRIKE READY", 
                              "Diamond Rewards", 
                              Icons.bolt_rounded, 
                              DesignTokens.highlight,
                              () => _navigate(const DimondTips()),
                            ),
                            const SizedBox(width: 16),
                            _buildFeaturedCard(
                              "ELITE_SQUAD", 
                              "Character Index", 
                              Icons.psychology_rounded, 
                              DesignTokens.primary,
                              () {
                                final provider = Provider.of<HomeProvider>(context, listen: false);
                                _navigate(CharactersScreen(
                                  appBarTitle: "Elite Characters", 
                                  characters: provider.characters, 
                                  isSquared: false
                                ));
                               },
                            ),
                            const SizedBox(width: 16),
                            _buildFeaturedCard(
                              "ARMORY_SYNC", 
                              "Pro Weapons", 
                              Icons.military_tech_rounded, 
                              DesignTokens.warning,
                              () {
                                final provider = Provider.of<HomeProvider>(context, listen: false);
                                _navigate(CharactersScreen(
                                  appBarTitle: "Pro Weapons", 
                                  characters: provider.weapons, 
                                  isSquared: true
                                ));
                               },
                            ),
                            const SizedBox(width: 16),
                            _buildFeaturedCard(
                              "NEURAL_LINK", 
                              "Battle Pets", 
                              Icons.pets_rounded, 
                              DesignTokens.secondary,
                              () {
                                final provider = Provider.of<HomeProvider>(context, listen: false);
                                _navigate(CharactersScreen(
                                  appBarTitle: "Tactical Pets", 
                                  characters: provider.pets, 
                                  isSquared: false
                                ));
                               },
                            ),
                            const SizedBox(width: 16),
                            _buildFeaturedCard(
                              "VEHICLE_GRID", 
                              "Combat Vehicles", 
                              Icons.speed_rounded, 
                              DesignTokens.highlight,
                              () {
                                final provider = Provider.of<HomeProvider>(context, listen: false);
                                _navigate(CharactersScreen(
                                  appBarTitle: "Battle Vehicles", 
                                  characters: provider.vehicles, 
                                  isSquared: true
                                ));
                               },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Section: Advanced Grid
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 48, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: GradientHeader(
                    title: "System Grid",
                    fontSize: 12,
                  ),
                ),
              ),

              _buildMainGrid(),

              // Ad Section
              if (RemoteConfigService.isAdsShow) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: NativeAdsScreen(),
                  ),
                ),
              ],

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
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
          right: -100,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.grid_4x4_rounded, size: 450, color: DesignTokens.primary),
          ),
        ),
        Positioned(
          bottom: 200,
          left: -80,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.shield_rounded, size: 380, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarOverlay() {
    return Positioned(
      bottom: 80,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            borderRadius: 6,
            opacity: 0.1,
            blur: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: DesignTokens.highlight,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: DesignTokens.highlight, blurRadius: 4)],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "SECURE PROTOCOL ACTIVE",
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "SYS_LINK_07",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary.withOpacity(0.3),
              letterSpacing: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return PremiumDashboardCard(
      width: 70,
      height: 70,
      borderRadius: 18,
      color: DesignTokens.secondary,
      child: Center(
        child: Icon(
          Icons.person_outline_rounded,
          color: DesignTokens.secondary,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: DesignTokens.highlight.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DesignTokens.highlight.withOpacity(0.3)),
      ),
      child: Text(
        "ONLINE",
        style: GoogleFonts.outfit(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: DesignTokens.highlight,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String label, String title, IconData icon, Color color, VoidCallback onTap) {
    return PremiumDashboardCard(
      width: 200,
      height: 120,
      color: color,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Icon(Icons.north_east_rounded, color: color.withOpacity(0.5), size: 16),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: color.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildListDelegate([
          _buildMenuTile(
            "Rank System", 
            "Combat Stats", 
            Icons.trending_up_rounded, 
            DesignTokens.secondary,
            () => _navigate(SelectRankScreen(model: _defaultModel)),
          ),
          _buildMenuTile(
            "ID Forge", 
            "Nickname Tool", 
            Icons.badge_rounded, 
            DesignTokens.primary,
            () => _navigate(NickNameScreen(model: _defaultModel)),
          ),
          _buildMenuTile(
            "Vault Matrix", 
            "Rare Bundles", 
            Icons.auto_awesome_motion_rounded, 
            DesignTokens.highlight,
            () {
              final provider = Provider.of<HomeProvider>(context, listen: false);
              _navigate(CharactersScreen(
                appBarTitle: "Legendary Bundles", 
                characters: provider.bundles, 
                isSquared: false
              ));
            },
          ),
          _buildMenuTile(
            "Reward Center", 
            "Claim Assets", 
            Icons.card_giftcard_rounded, 
            DesignTokens.warning,
            () => _navigate(ClaimScreen(model: _defaultModel)),
          ),
          _buildMenuTile(
            "Performance", 
            "Ranked Check", 
            Icons.analytics_rounded, 
            DesignTokens.secondary,
            () => _navigate(RankedScreen(model: _defaultModel)),
          ),
          _buildMenuTile(
            "System Setup", 
            "User Settings", 
            Icons.settings_suggest_rounded, 
            DesignTokens.primary,
            () => _navigate(const SettingScreen()),
          ),
        ]),
      ),
    );
  }

  Widget _buildMenuTile(String title, String sub, IconData icon, Color accentColor, VoidCallback onTap) {
    return PremiumDashboardCard(
      onTap: onTap,
      color: accentColor,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GlowContainer(
              glowColor: accentColor,
              blurRadius: 15,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
                ),
                child: Icon(icon, color: accentColor, size: 24),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(Widget screen) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}





