import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/common_button/common_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String url;

  const PrivacyPolicyScreen({
    super.key,
    required this.url,
  });

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(DesignTokens.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Column(
        children: [
          _buildTacticalHeader(context),

          Expanded(
            child: Stack(
              children: [
                Container(
                  color: DesignTokens.background,
                  child: WebViewWidget(controller: _controller),
                ),

                if (_isLoading) _buildPremiumLoader(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTacticalHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        border: Border(
          bottom: BorderSide(
            color: DesignTokens.primary.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GlowIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: () async {
              await CommonOnTap.openUrl();
              await Future.delayed(const Duration(milliseconds: 400));
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            color: DesignTokens.textPrimary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PRIVACY_MANIFESTO",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "SECURE_PROTOCOL_v3.4.0",
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          GlowContainer(
            glowColor: DesignTokens.primary,
            child: Icon(Icons.security_rounded,
                color: DesignTokens.primary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumLoader() {
    return Container(
      color: DesignTokens.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GlowContainer(
              glowColor: DesignTokens.primary,
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "ESTABLISHING_SECURE_UPLINK",
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textSecondary.withOpacity(0.8),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 120,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: DesignTokens.primary.withOpacity(0.05),
                valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary.withOpacity(0.3)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

