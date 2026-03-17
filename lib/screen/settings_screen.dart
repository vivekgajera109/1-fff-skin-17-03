import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (RemoteConfigService.isAdsShow) ...[
              const NativeAdsScreen(),
              const SizedBox(height: DesignTokens.spacing32),
            ],

            Text(
              "Account & App",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            _buildSettingTile(
              icon: Icons.share_rounded,
              title: "Share App",
              subtitle: "Share the experience with your friends",
              accentColor: DesignTokens.primary,
              onTap: _shareApp,
            ),
            const SizedBox(height: DesignTokens.spacing12),
            _buildSettingTile(
              icon: Icons.star_rounded,
              title: "Rate Us",
              subtitle: "Support us by giving a high rating",
              accentColor: const Color(0xFFF59E0B),
              onTap: _openAppUrl,
            ),
            
            const SizedBox(height: DesignTokens.spacing32),
            Text(
              "Support & Privacy",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            _buildSettingTile(
              icon: Icons.privacy_tip_rounded,
              title: "Privacy Policy",
              subtitle: "How we protect your gaming data",
              accentColor: DesignTokens.secondary,
              onTap: () async {
                final url = RemoteConfigService.getPrivacyPolicyUrl();
                await CommonOnTap.openUrl();
                await Future.delayed(const Duration(milliseconds: 200));
                if (!context.mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PrivacyPolicyScreen(url: url)));
              },
            ),
            const SizedBox(height: 12),
            _buildSettingTile(
              icon: Icons.info_outline_rounded,
              title: "Version",
              subtitle: "Stable Build 1.0.8",
              accentColor: DesignTokens.textSecondary,
              onTap: () {},
            ),
            const SizedBox(height: 60),
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
    return SimpleCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
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
          Icon(Icons.arrow_forward_ios_rounded, color: DesignTokens.textSecondary.withOpacity(0.2), size: 14),
        ],
      ),
    );
  }

  Future<void> _shareApp() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    final url = RemoteConfigService.getAppUrl();
    if (url.isEmpty) return;
    try {
      await Share.share('Join the ultimate gaming experience! Download here: $url');
    } catch (e) {}
  }

  Future<void> _openAppUrl() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
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



