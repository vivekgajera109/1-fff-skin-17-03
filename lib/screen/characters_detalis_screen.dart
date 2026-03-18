import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/primary_button.dart';
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

    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: Stack(
          children: [
            // Scrollable content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Hero image area (not a SliverAppBar — freeform)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: size.height * 0.46,
                    child: Stack(
                      children: [
                        // Coloured bg
                        Container(
                          width: double.infinity,
                          height: size.height * 0.46,
                          color: const Color(0xFFEEF0FD),
                        ),
                        // Image
                        Positioned.fill(
                          child: Hero(
                            tag: 'character_${characters.title}',
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(32, 70, 32, 24),
                              child: characters.image != null
                                  ? Image.asset(characters.image!,
                                      fit: BoxFit.contain)
                                  : const Icon(Icons.inventory_2_outlined,
                                      size: 120, color: DesignTokens.primary),
                            ),
                          ),
                        ),
                        // Fade bottom
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFFF5F5F7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Back button
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          left: 12,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                  color: DesignTokens.textPrimary),
                            ),
                          ),
                        ),
                        // Premium badge top-right
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 14,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: DesignTokens.primary.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.sports_esports_rounded,
                                    size: 12, color: DesignTokens.primary),
                                const SizedBox(width: 4),
                                Text(
                                  "FREE FIRE",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: DesignTokens.primary,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          characters.title,
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: DesignTokens.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        if ((characters.subTitle ?? '').isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            characters.subTitle!,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: DesignTokens.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Text(
                          characters.description ??
                              "A powerful Free Fire item available exclusively for skilled players. Get it now and dominate the battlefield.",
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: DesignTokens.textSecondary,
                            height: 1.65,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Ads
                        if (RemoteConfigService.isAdsShow) ...[
                          const BanerAdsScreen(),
                          const SizedBox(height: 24),
                        ],

                        // Stat chips row
                        Row(
                          children: [
                            _statChip(Icons.style_rounded, "TYPE", "SKIN",
                                DesignTokens.primary),
                            const SizedBox(width: 10),
                            _statChip(Icons.workspace_premium_rounded, "GRADE",
                                "S+", DesignTokens.secondary),
                            const SizedBox(width: 10),
                            _statChip(Icons.card_giftcard_rounded, "STATUS",
                                "FREE", DesignTokens.accent),
                          ],
                        ),

                        const SizedBox(height: 28),

                        if (RemoteConfigService.isAdsShow) ...[
                          const NativeAdsScreen(),
                          const SizedBox(height: 28),
                        ],

                        // Action section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color:
                                      DesignTokens.secondary.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_rounded,
                                        size: 13,
                                        color: DesignTokens.secondary),
                                    const SizedBox(width: 5),
                                    Text(
                                      "100% Free · No Root Required",
                                      style: GoogleFonts.outfit(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: DesignTokens.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                "Get This Item Free",
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: DesignTokens.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Tap the button below to unlock this item on your Free Fire account instantly.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: DesignTokens.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              PrimaryButton(
                                text: "Get For Free",
                                icon: Icons.card_giftcard_rounded,
                                onPressed: () => _onDeploy(context),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 13, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textSecondary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
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
