import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../model/home_item_model.dart';

class DimondTipsDetalis extends StatelessWidget {
  final HomeItemModel item;

  const DimondTipsDetalis({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        title: const Text("Tip Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (RemoteConfigService.isAdsShow) ...[
              const BanerAdsScreen(),
              const SizedBox(height: DesignTokens.spacing24),
            ],

            SimpleCard(
              padding: const EdgeInsets.all(DesignTokens.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: DesignTokens.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "PRO STRATEGY",
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.secondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.title,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: DesignTokens.textPrimary,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: DesignTokens.border, height: 32),
                  Text(
                    item.subTitle ?? "Strategy details are currently being updated with the latest in-game meta changes. Check back soon for the full guide and tactical analysis.",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: DesignTokens.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            if (RemoteConfigService.isAdsShow) ...[
              const SizedBox(height: DesignTokens.spacing24),
              const NativeAdsScreen(),
            ],
            
            const SizedBox(height: 40),
            
            PrimaryButton(
              text: 'Got it!',
              onPressed: () => Navigator.pop(context),
            ),
            
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}



