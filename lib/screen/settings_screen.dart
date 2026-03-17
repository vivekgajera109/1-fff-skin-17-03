import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
                title: "System CONFIG",
                expandedHeight: 220,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    top: 40,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.settings_suggest_rounded, size: 180, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (RemoteConfigService.isAdsShow) ...[
                      const NativeAdsScreen(),
                      const SizedBox(height: 32),
                    ],

                    const GradientHeader(
                      title: 'CORE_INTERFACE',
                      fontSize: 13,
                    ),
                    const SizedBox(height: 24),
                    _buildSettingTile(
                      icon: Icons.share_rounded,
                      title: "RELAY_NODE",
                      subtitle: "Broadcast link to neural network",
                      accentColor: DesignTokens.primary,
                      onTap: _shareApp,
                    ),
                    const SizedBox(height: 16),
                    _buildSettingTile(
                      icon: Icons.star_rounded,
                      title: "SYSTEM_RATING",
                      subtitle: "Evaluate core backend performance",
                      accentColor: const Color(0xFFFFD700),
                      onTap: _openAppUrl,
                    ),
                    const SizedBox(height: 40),

                    const GradientHeader(
                      title: 'SECURITY_MATRIX',
                      fontSize: 13,
                    ),
                    const SizedBox(height: 24),
                    _buildSettingTile(
                      icon: Icons.shield_rounded,
                      title: "PRIVACY_MANIFESTO",
                      subtitle: "Encrypted data management protocols",
                      accentColor: DesignTokens.secondary,
                      onTap: () async {
                        final url = RemoteConfigService.getPrivacyPolicyUrl();
                        await CommonOnTap.openUrl();
                        await Future.delayed(const Duration(milliseconds: 400));
                        if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PrivacyPolicyScreen(url: url)));
                      },
                    ),
                    const SizedBox(height: 60),
                    
                    Center(
                      child: _buildVersionBadge(),
                    ),
                    const SizedBox(height: 100),
                  ]),
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
          bottom: 200,
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.security_rounded, size: 300, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildVersionBadge() {
    return PremiumDashboardCard(
      color: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: DesignTokens.secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: DesignTokens.secondary, blurRadius: 6)
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "BUILD_STABLE_1.0.8",
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return PremiumDashboardCard(
      onTap: onTap,
      color: accentColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            GlowContainer(
              glowColor: accentColor,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
                ),
                child: Icon(icon, color: accentColor, size: 24),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.textPrimary,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: DesignTokens.textSecondary.withOpacity(0.3), size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _shareApp() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    final url = RemoteConfigService.getAppUrl();
    if (url.isEmpty) return;
    try {
      await Share.share('Establish connection to the ultimate gaming portal! Link: $url');
    } catch (e) {}
  }

  Future<void> _openAppUrl() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    final url = RemoteConfigService.getAppUrl();
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {}
  }
}



