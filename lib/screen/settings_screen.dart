import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
                if (RemoteConfigService.isAdsShow) ...[
                  const NativeAdsScreen(),
                  const SizedBox(height: 40),
                ],

                const GradientHeader(title: "IDENTITY & DEPLOYMENT", fontSize: 13),
                const SizedBox(height: 20),
                _buildUniqueSettingTile(
                  context,
                  icon: Icons.share_rounded,
                  title: "SHARE ELITE HUB",
                  subtitle: "Sync tactical tools with squad members",
                  status: "READY",
                  accentColor: DesignTokens.primary,
                  onTap: _shareApp,
                ),
                const SizedBox(height: 16),
                _buildUniqueSettingTile(
                  context,
                  icon: Icons.star_rounded,
                  title: "CORE FEEDBACK",
                  subtitle: "Optimize our algorithms for elite play",
                  status: "PENDING",
                  accentColor: const Color(0xFFF59E0B),
                  onTap: _openAppUrl,
                ),
                
                const SizedBox(height: 40),
                const GradientHeader(title: "GOVERNANCE & PROTOCOLS", fontSize: 13),
                const SizedBox(height: 20),
                _buildUniqueSettingTile(
                  context,
                  icon: Icons.privacy_tip_rounded,
                  title: "DATA SECURE CRYPT",
                  subtitle: "Review your secure uplink protocols",
                  status: "SECURED",
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
                const SizedBox(height: 16),
                _buildUniqueSettingTile(
                  context,
                  icon: Icons.info_outline_rounded,
                  title: "SYSTEM RUNTIME",
                  subtitle: "Version 1.0.8 (Stable Fragment)",
                  status: "ACTIVE",
                  accentColor: DesignTokens.textSecondary,
                  onTap: () {},
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: DesignTokens.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        "CORE PROTOCOLS",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: DesignTokens.textPrimary,
          letterSpacing: 2.5,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildUniqueSettingTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CyberFrameCard(
        accentColor: accentColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
               // Icon Hub
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                  border: Border.all(color: accentColor.withOpacity(0.2)),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
               // Tech Status Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: accentColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
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



