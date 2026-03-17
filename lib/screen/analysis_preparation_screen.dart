import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
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
  State<AnalysisPreparationScreen> createState() =>
      _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState
    extends State<AnalysisPreparationScreen>
    with TickerProviderStateMixin {
  late AnimationController _ring1Ctrl;
  late AnimationController _ring2Ctrl;
  late AnimationController _ring3Ctrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'AnalysisPreparationScreen');

    _ring1Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
    _ring2Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 12))
      ..repeat();
    _ring3Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.94, end: 1.06).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ring1Ctrl.dispose();
    _ring2Ctrl.dispose();
    _ring3Ctrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

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
                title: "Neural LINK",
                expandedHeight: 220,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -30,
                    bottom: -15,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.hub_rounded, size: 200, color: DesignTokens.primary),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      _buildScannerHero(),
                      const SizedBox(height: 64),
                      _buildProgressPanel(),
                      const SizedBox(height: 48),
                      const GradientHeader(title: 'SYSTEM_LOGS', fontSize: 13),
                      const SizedBox(height: 24),
                      _buildLogItem("BYPASS_GATEWAY", true, "OK"),
                      _buildLogItem("NEURAL_INJECTION", true, "100%"),
                      _buildLogItem("ESTABLISH_UPLINK", true, "SYNC"),
                      _buildLogItem("DATA_STAGING", false, "WAITING"),
                      const SizedBox(height: 48),
                      _buildExecutionPanel(),
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
          top: 400,
          left: -40,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.filter_tilt_shift_rounded, size: 380, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildScannerHero() {
    return Column(
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      DesignTokens.primary.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              RotationTransition(
                turns: _ring1Ctrl,
                child: _buildRing(260, DesignTokens.primary.withOpacity(0.15), 1),
              ),
              RotationTransition(
                turns: Tween(begin: 1.0, end: 0.0).animate(_ring2Ctrl),
                child: _buildRing(210, DesignTokens.secondary.withOpacity(0.2), 2),
              ),
              RotationTransition(
                turns: _ring3Ctrl,
                child: _buildRing(160, DesignTokens.highlight.withOpacity(0.3), 1),
              ),

              ScaleTransition(
                scale: _pulseAnim,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: 'character_${widget.model.title}',
                    child: widget.model.image != null 
                        ? Image.asset(widget.model.image!, fit: BoxFit.contain)
                        : Icon(Icons.verified_user_rounded, size: 80, color: DesignTokens.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "PROTOCOL_ALPHA_ACTIVE",
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: DesignTokens.primary,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.model.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildRing(double size, Color color, int dashCount) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Stack(
        children: List.generate(dashCount, (i) {
          final angle = (i * (360 / dashCount)) * 0.0174533;
          return Positioned(
            left: size / 2 + (size / 2 - 1) * math.cos(angle) - 6,
            top: size / 2 + (size / 2 - 1) * math.sin(angle) - 6,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: color, blurRadius: 12),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressPanel() {
    return PremiumDashboardCard(
      color: DesignTokens.primary,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                GlowContainer(
                  glowColor: DesignTokens.primary,
                  child: Icon(Icons.bolt_rounded, color: DesignTokens.primary, size: 28),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Uplink Bridge",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      Text(
                        "Synchronizing neural pathways",
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "92%",
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                LayoutBuilder(builder: (context, c) {
                  return Container(
                    width: c.maxWidth * 0.92,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [DesignTokens.primary, DesignTokens.secondary],
                      ),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: DesignTokens.primary.withOpacity(0.5), 
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String title, bool completed, String status) {
    final color = completed ? DesignTokens.primary : DesignTokens.textSecondary.withOpacity(0.4);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: completed ? DesignTokens.primary.withOpacity(0.04) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(completed ? Icons.verified_rounded : Icons.radio_button_off_rounded, 
               size: 16, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: completed ? DesignTokens.textPrimary : DesignTokens.textSecondary.withOpacity(0.5),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Text(
            status,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutionPanel() {
    return PremiumDashboardCard(
      color: DesignTokens.secondary,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            if (RemoteConfigService.isAdsShow) ...[
              const NativeAdsScreen(),
              const SizedBox(height: 32),
            ],
            Icon(Icons.bolt_rounded, color: DesignTokens.secondary, size: 48),
            const SizedBox(height: 24),
            Text(
              "INITIALIZE LINK",
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "All protocols verified. Finalize the character handshake to establish the permanent neural link.",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary, 
                fontSize: 14, 
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            CyberButton(
              text: "ESTABLISH LINK",
              onPressed: () => _onExecute(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onExecute(BuildContext context) async {
    await AnalyticsService.logEvent(
        eventName: 'analysis_preparation_started',
        parameters: {'item_name': widget.model.title});
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => NickNameScreen(model: widget.model)));
  }
}




