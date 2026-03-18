import 'package:fff_skin_tools/widgets/premium_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/analytics_service.dart';
import '../common/common_button/common_button.dart';
import 'nick_name_screen.dart';
import '../helper/remote_config_service.dart';

class AnalysisPreparationScreen extends StatefulWidget {
  final HomeItemModel model;

  const AnalysisPreparationScreen({
    super.key,
    required this.model,
  });

  @override
  State<AnalysisPreparationScreen> createState() => _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState extends State<AnalysisPreparationScreen> with TickerProviderStateMixin {
  late AnimationController _progressCtrl;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'AnalysisPreparationScreen');

    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _progressCtrl.addListener(() {
      setState(() {
        _progress = _progressCtrl.value;
      });
    });

    _progressCtrl.forward();
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

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
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 32),
                  _buildProgressModule(),
                  const SizedBox(height: 48),
                  const GradientHeader(title: "Execution Logs", fontSize: 13),
                  const SizedBox(height: 20),
                  _buildLogSection(),
                  const SizedBox(height: 48),
                  if (RemoteConfigService.isAdsShow) ...[
                    const NativeAdsScreen(),
                    const SizedBox(height: 48),
                  ],
                  _buildActionTerminal(),
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
        "STAGING PHASE",
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

  Widget _buildStatusCard() {
    return CyberFrameCard(
      accentColor: DesignTokens.primary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: DesignTokens.primary.withOpacity(0.1)),
              ),
              child: Center(
                child: Hero(
                  tag: 'character_${widget.model.title}',
                  child: widget.model.image != null
                      ? Image.asset(widget.model.image!, height: 50, fit: BoxFit.contain)
                      : const Icon(Icons.security_rounded, size: 28, color: DesignTokens.primary),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: DesignTokens.secondary.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
                    ),
                    child: Text(
                      "PROTO STAGE V2.0",
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: DesignTokens.secondary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressModule() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: DesignTokens.surface.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        border: Border.all(color: DesignTokens.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OPTIMIZATION BUFFER",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.textPrimary,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "${(_progress * 100).toInt()}%",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Stack(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: DesignTokens.border.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _progress,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: DesignTokens.primary,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.radar_rounded, color: DesignTokens.textMuted.withOpacity(0.4), size: 12),
              const SizedBox(width: 8),
              Text(
                "SYNCING BITSTREAM...",
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.textMuted.withOpacity(0.6),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogSection() {
    return Column(
      children: [
        _buildLogItem("Profile Identification", _progress > 0.3),
        _buildLogItem("Metadata Synchronization", _progress > 0.6),
        _buildLogItem("Server Link Verification", _progress > 0.9),
      ],
    );
  }

  Widget _buildLogItem(String title, bool isDone) {
    final color = isDone ? DesignTokens.secondary : DesignTokens.textMuted;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDone ? DesignTokens.surface.withOpacity(0.5) : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border.all(
          color: isDone ? color.withOpacity(0.2) : DesignTokens.border.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isDone ? FontWeight.w900 : FontWeight.w600,
                color: isDone ? DesignTokens.textPrimary : DesignTokens.textMuted,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Text(
            isDone ? "COMPLETE" : "STAGING",
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: isDone ? DesignTokens.secondary : DesignTokens.textMuted.withOpacity(0.4),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTerminal() {
    bool isComplete = _progress >= 1.0;
    return Opacity(
      opacity: isComplete ? 1.0 : 0.3,
      child: CyberFrameCard(
        accentColor: DesignTokens.secondary,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Text(
                "VERIFICATION COMPLETE",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.secondary,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Execute Final Link",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: DesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Authentication buffer is primed. Tap to execute the final handshake with your account bits.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: DesignTokens.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              CyberButton(
                text: "EXECUTE PROTOCOL",
                icon: Icons.bolt_rounded,
                onPressed: isComplete ? () => _onExecute(context) : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onExecute(BuildContext context) async {
    await AnalyticsService.logEvent(eventName: 'analysis_preparation_started', parameters: {'item_name': widget.model.title});
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NickNameScreen(model: widget.model)));
  }
}




