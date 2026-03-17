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
  State<AnalysisPreparationScreen> createState() =>
      _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState
    extends State<AnalysisPreparationScreen>
    with TickerProviderStateMixin {
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
      appBar: AppBar(
        title: const Text("Preparation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          children: [
            _buildHeaderHero(),
            const SizedBox(height: DesignTokens.spacing32),
            _buildProgressCard(),
            const SizedBox(height: DesignTokens.spacing32),
            _buildLogSection(),
            const SizedBox(height: DesignTokens.spacing32),
            if (RemoteConfigService.isAdsShow) ...[
              const NativeAdsScreen(),
              const SizedBox(height: DesignTokens.spacing32),
            ],
            _buildActionPanel(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderHero() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DesignTokens.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Hero(
            tag: 'character_${widget.model.title}',
            child: widget.model.image != null 
                ? Image.asset(widget.model.image!, fit: BoxFit.contain)
                : const Icon(Icons.shield_outlined, size: 60, color: DesignTokens.primary),
          ),
        ),
        const SizedBox(height: DesignTokens.spacing20),
        Text(
          widget.model.title,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
        ),
        Text(
          "Analyzing synchronization protocols",
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return SimpleCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Overall Progress",
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: DesignTokens.textPrimary,
                ),
              ),
              Text(
                "${(_progress * 100).toInt()}%",
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: DesignTokens.primary.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(DesignTokens.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "SYSTEM STATUS",
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: DesignTokens.textSecondary,
              letterSpacing: 1,
            ),
          ),
        ),
        _buildLogItem("Verification", _progress > 0.3),
        _buildLogItem("Internal Check", _progress > 0.6),
        _buildLogItem("Final Staging", _progress > 0.9),
      ],
    );
  }

  Widget _buildLogItem(String title, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDone ? DesignTokens.secondary.withOpacity(0.05) : DesignTokens.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDone ? DesignTokens.secondary.withOpacity(0.3) : DesignTokens.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
            size: 18,
            color: isDone ? DesignTokens.secondary : DesignTokens.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
              color: isDone ? DesignTokens.textPrimary : DesignTokens.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            isDone ? "OK" : "PENDING",
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isDone ? DesignTokens.secondary : DesignTokens.textSecondary.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPanel() {
    bool isComplete = _progress >= 1.0;
    return SimpleCard(
      child: Column(
        children: [
          const Icon(Icons.flash_on_rounded, color: DesignTokens.accent, size: 32),
          const SizedBox(height: DesignTokens.spacing12),
          Text(
            "Final Step",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Everything is ready for your game account.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing24),
          PrimaryButton(
            text: "Proceed to Final Step",
            onPressed: isComplete ? () => _onExecute(context) : null,
          ),
        ],
      ),
    );
  }

  Future<void> _onExecute(BuildContext context) async {
    await AnalyticsService.logEvent(
        eventName: 'analysis_preparation_started',
        parameters: {'item_name': widget.model.title});
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => NickNameScreen(model: widget.model)));
  }
}




