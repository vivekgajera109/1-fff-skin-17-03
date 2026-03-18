import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
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
    final size = MediaQuery.of(context).size;
    final accentColor = _getAccentColor(characters.title);

    return PageWrapper(
      useSafeArea: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero Section
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height * 0.52,
              child: Stack(
                children: [
                   // Dynamic Background Glow
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            accentColor.withOpacity(0.15),
                            DesignTokens.background,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Floating Particles (Simulated)
                  Positioned(
                    top: 100,
                    right: 40,
                    child: Icon(Icons.blur_on_rounded, color: accentColor.withOpacity(0.1), size: 100),
                  ),
                  
                  // Character Image with Reflection and Aura
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: Hero(
                        tag: 'character_${characters.title}',
                        child: CyberImageFrame(
                          imagePath: characters.image,
                          accentColor: accentColor,
                          height: size.height * 0.4,
                        ),
                      ),
                    ),
                  ),

                  // Floating Back Button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 20,
                    child: GlowIconButton(
                      icon: Icons.close_rounded,
                      size: 18,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),

                  // ID Badge
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 20,
                    right: 20,
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      borderRadius: DesignTokens.radiusFull,
                      child: Text(
                        "DATA-ARCHIVE #${characters.title.hashCode.toString().substring(0, 4)}",
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: accentColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                Text(
                  characters.title.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -1,
                  ),
                ),
                if ((characters.subTitle ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.flash_on_rounded, color: accentColor, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        characters.subTitle!.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: accentColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  characters.description ??
                      "Enhance your gaming experience with this exclusive premium item. Designed for top-tier performance and prestige on the battlefield.",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: DesignTokens.textSecondary,
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 48),

                // Stats Unique Grid
                Row(
                  children: [
                    _buildStatModule(Icons.bolt_rounded, "POWER", "99+", accentColor),
                    const SizedBox(width: 12),
                    _buildStatModule(Icons.verified_rounded, "GRADE", "S+", DesignTokens.secondary),
                    const SizedBox(width: 12),
                    _buildStatModule(Icons.lock_open_rounded, "STATUS", "FREE", const Color(0xFF6C5CE7)),
                  ],
                ),

                const SizedBox(height: 48),

                if (RemoteConfigService.isAdsShow) ...[
                  const NativeAdsScreen(),
                  const SizedBox(height: 48),
                ],

                // Action Panel
                CyberFrameCard(
                  accentColor: accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Text(
                          "ESTABLISH UPLINK",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: accentColor,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Direct Synchronization Ready",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: DesignTokens.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Sync will initiate a secure handshake with the server to inject assets.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: DesignTokens.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CyberButton(
                          text: "INITIATE PROTOCOL",
                          icon: Icons.sync_rounded,
                          onPressed: () => _onDeploy(context),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatModule(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: DesignTokens.surface.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textMuted,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAccentColor(String title) {
    if (title.contains("Skins")) return DesignTokens.primary;
    if (title.contains("Weapons")) return DesignTokens.secondary;
    return DesignTokens.primary;
  }

  Future<void> _onDeploy(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnalysisPreparationScreen(model: characters)),
    );
  }
}
