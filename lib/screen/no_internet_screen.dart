import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../theme/design_tokens.dart';
import '../widgets/simple_card.dart';
import '../widgets/primary_button.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _checking = false;

  Future<void> _retryConnection() async {
    if (_checking) return;

    setState(() => _checking = true);

    await Future.delayed(const Duration(milliseconds: 1500));

    final hasInternet =
        await InternetConnectionChecker.createInstance().hasConnection;

    if (!mounted) return;

    setState(() => _checking = false);

    if (hasInternet && mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: DesignTokens.accent.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    size: 80,
                    color: DesignTokens.accent,
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  "Connection Lost",
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "It seems your internet connection is unavailable. Please check your settings and try again.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: DesignTokens.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SimpleCard(
                  padding: const EdgeInsets.all(DesignTokens.spacing24),
                  child: Column(
                    children: [
                      if (_checking)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Checking Connection...",
                              style: GoogleFonts.outfit(
                                color: DesignTokens.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      else
                        PrimaryButton(
                          text: "Retry Connection",
                          onPressed: _retryConnection,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Status: Offline",
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: DesignTokens.textSecondary.withOpacity(0.5),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


