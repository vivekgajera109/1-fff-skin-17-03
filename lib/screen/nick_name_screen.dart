import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import 'ranked_screen.dart';
import '../helper/remote_config_service.dart';
import '../common/common_button/common_button.dart';

class NickNameScreen extends StatelessWidget {
  final HomeItemModel model;
  final TextEditingController _controller = TextEditingController();

  NickNameScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSyncUplinkHeader(),
                  const SizedBox(height: 32),
                  const GradientHeader(title: "Target Asset", fontSize: 13),
                  const SizedBox(height: 16),
                  _buildInfoCard(),
                  const SizedBox(height: 48),
                  const GradientHeader(title: "Identity Verification", fontSize: 13),
                  const SizedBox(height: 16),
                  _buildInputTerminal(context),
                  const SizedBox(height: 56),
                  if (RemoteConfigService.isAdsShow) ...[
                    const NativeAdsScreen(),
                    const SizedBox(height: 56),
                  ],
                  CyberButton(
                    text: "COMMIT FRAGMENT",
                    icon: Icons.security_rounded,
                    onPressed: () => _onProceed(context),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
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
        "ENCRYPTED SYNC",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: DesignTokens.textPrimary,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSyncUplinkHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DesignTokens.secondary.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: DesignTokens.secondary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.hub_rounded, color: DesignTokens.secondary, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SECURE UPLINK ACTIVE",
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: DesignTokens.secondary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Fragment mapping initialized. Payload secure.",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: DesignTokens.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Column(
      children: [
        Center(
          child: Hero(
            tag: 'character_${model.title}',
            child: CyberImageFrame(
              imagePath: model.image,
              accentColor: DesignTokens.primary,
              height: 200,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          model.title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: DesignTokens.primary.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
          ),
          child: Text(
            "TARGET ASSET VERIFIED",
            style: GoogleFonts.inter(
              fontSize: 10,
              color: DesignTokens.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputTerminal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: DesignTokens.surface.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(color: DesignTokens.border.withOpacity(0.4)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                filled: false,
              ),
            ),
            child: TextField(
              controller: _controller,
              style: GoogleFonts.inter(
                color: DesignTokens.primary,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 3,
              ),
              cursorColor: DesignTokens.primary,
              decoration: InputDecoration(
                hintText: "_ _ _ _ _ _ _ _ _",
                hintStyle: GoogleFonts.inter(
                  color: DesignTokens.textMuted.withOpacity(0.2),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
                prefixIcon: const Icon(Icons.terminal_rounded, color: DesignTokens.primary, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TERMINAL ID REQUIRED",
                style: GoogleFonts.inter(
                  color: DesignTokens.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Deployment bits requires a unique session identifier to map the fragment to your terminal profile.",
                style: GoogleFonts.inter(
                  color: DesignTokens.textSecondary,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onProceed(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => RankedScreen(model: model)));
  }
}



