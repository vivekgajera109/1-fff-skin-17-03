import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
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
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 32),
                  _buildProgressCard(),
                  const SizedBox(height: 40),
                  _buildLogSection(),
                  const SizedBox(height: 40),
                  if (RemoteConfigService.isAdsShow) ...[
                    const NativeAdsScreen(),
                    const SizedBox(height: 40),
                  ],
                  _buildActionPanel(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110,
      pinned: true,
      elevation: 0,
      backgroundColor: DesignTokens.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: DesignTokens.primaryGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -10,
                child: Icon(
                  Icons.analytics_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          "Staging Phase",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return SimpleCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Hero(
                tag: 'character_${widget.model.title}',
                child: widget.model.image != null
                    ? Image.asset(widget.model.image!, height: 40, fit: BoxFit.contain)
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
                  widget.model.title,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Synchronization Protocol V.2",
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: DesignTokens.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return SimpleCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Optimization Staging",
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: DesignTokens.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${(_progress * 100).toInt()}%",
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: DesignTokens.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: DesignTokens.divider,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _progress,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: DesignTokens.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
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

  Widget _buildLogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 14, color: DesignTokens.primary),
            const SizedBox(width: 10),
            Text(
              "SYSTEM LOGS",
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: DesignTokens.textSecondary,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildLogItem("Profile Identification", _progress > 0.3),
        _buildLogItem("Metadata Synchronization", _progress > 0.6),
        _buildLogItem("Server Link Verification", _progress > 0.9),
      ],
    );
  }

  Widget _buildLogItem(String title, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: DesignTokens.lightShadow,
        border: Border.all(
          color: isDone ? DesignTokens.secondary.withOpacity(0.2) : DesignTokens.border.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDone ? DesignTokens.secondary.withOpacity(0.1) : DesignTokens.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDone ? Icons.check_rounded : Icons.sync_rounded,
              size: 14,
              color: isDone ? DesignTokens.secondary : DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: isDone ? FontWeight.w700 : FontWeight.w500,
              color: isDone ? DesignTokens.textPrimary : DesignTokens.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            isDone ? "VERIFIED" : "STAGING",
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: isDone ? DesignTokens.secondary : DesignTokens.textSecondary.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPanel() {
    bool isComplete = _progress >= 1.0;
    return SimpleCard(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignTokens.accent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.flash_on_rounded, color: DesignTokens.accent, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            "Protocol Finalized",
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Account synchronization ready for execution.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: DesignTokens.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: "Execute Synchronization",
            onPressed: isComplete ? () => _onExecute(context) : null,
          ),
        ],
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




