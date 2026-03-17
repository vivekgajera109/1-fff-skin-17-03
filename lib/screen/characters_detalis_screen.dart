import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'analysis_preparation_screen.dart';

class CharactersDetalisScreen extends StatelessWidget {
  final HomeItemModel characters;
  final bool isSquared;

  const CharactersDetalisScreen({
    super.key,
    required this.characters,
    this.isSquared = false,
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
              SliverAppBar(
                expandedHeight: 460.0,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: const Alignment(0, -0.2),
                            radius: 1.2,
                            colors: [
                              DesignTokens.primary.withOpacity(0.15),
                              DesignTokens.background,
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 150,
                        right: -40,
                        child: Opacity(
                          opacity: 0.03,
                          child: Text(
                            "ELITE\nPROTO",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.outfit(
                              fontSize: 120,
                              fontWeight: FontWeight.w900,
                              color: DesignTokens.primary,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        child: GlowIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          color: DesignTokens.textPrimary,
                          size: 16,
                          onTap: () async {
                            await CommonOnTap.openUrl();
                            await Future.delayed(const Duration(milliseconds: 400));
                            if (context.mounted) Navigator.pop(context);
                          },
                        ),
                      ),

                      Positioned(
                        top: 100,
                        bottom: 60,
                        left: 20,
                        right: 20,
                        child: Hero(
                          tag: 'character_${characters.title}',
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: DesignTokens.primary.withOpacity(0.2),
                                  blurRadius: 100,
                                  spreadRadius: -30,
                                ),
                              ],
                            ),
                            child: characters.image != null 
                                ? Image.asset(characters.image!, fit: BoxFit.contain)
                                : Icon(Icons.person_rounded, size: 200, color: DesignTokens.primary.withOpacity(0.3)),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                DesignTokens.background.withOpacity(0),
                                DesignTokens.background,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSection(),
                      const SizedBox(height: 48),

                      if (RemoteConfigService.isAdsShow) ...[
                        const BanerAdsScreen(),
                        const SizedBox(height: 40),
                      ],

                      _buildStatsRow(),
                      const SizedBox(height: 48),

                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 40),
                      ],

                      _buildActionPanel(context),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
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
          top: 500,
          left: -80,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.grid_4x4_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "SECURE ARCHIVE",
                style: GoogleFonts.outfit(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.primary,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildStatusTag("V_1.0.4", DesignTokens.secondary),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          characters.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            height: 1.0,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          characters.description ??
              "Neural profile synchronization complete. Tactical metrics optimized for high-end gaming environments. Deployment authorized for elite operatives only.",
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: DesignTokens.textSecondary,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatBox("POWER", "S-TYPE", DesignTokens.primary),
        const SizedBox(width: 12),
        _buildStatBox("SYNC", "100%", DesignTokens.secondary),
        const SizedBox(width: 12),
        _buildStatBox("TIER", "LEGEND", DesignTokens.highlight),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Expanded(
      child: PremiumDashboardCard(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 8,
                  color: DesignTokens.textSecondary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return PremiumDashboardCard(
      color: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                GlowContainer(
                  glowColor: DesignTokens.secondary,
                  child: Icon(Icons.bolt_rounded, color: DesignTokens.secondary, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Protocol Link",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      Text(
                        "Initialize neural deployment",
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            CyberButton(
              text: "INITIALIZE DEPLOY",
              isLoading: false,
              onPressed: () => _onDeploy(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeploy(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AnalysisPreparationScreen(model: characters)));
  }
}




