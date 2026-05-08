import 'package:flutter/material.dart';
import 'package:tetris/theme/app_theme.dart';
import 'package:tetris/widgets/app_image_banner.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: kSurfaceColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: _TermsContent(),
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  const _TermsContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PolicyHeader(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          lastUpdated: 'Last updated: January 1, 2026',
        ),
        SizedBox(height: 20),
        AppImageBanner(),
        SizedBox(height: 24),
        _TermsSection(
          title: '1. Acceptance of Terms',
          content:
              'By downloading, installing, or using the Tetris application ("the App"), you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the App.',
        ),
        _TermsSection(
          title: '2. License to Use',
          content:
              'We grant you a limited, non-exclusive, non-transferable, revocable license to use the App for personal, non-commercial purposes. This license does not include the right to:\n\n• Copy, modify, or distribute the App\n• Reverse-engineer or decompile the App\n• Create derivative works based on the App\n• Use the App for commercial purposes without written consent',
        ),
        _TermsSection(
          title: '3. Game Rules and Fair Play',
          content:
              'The App is intended for fair and legitimate gameplay. You agree not to:\n\n• Use automated scripts, bots, or hacks to manipulate the game\n• Exploit bugs or glitches to gain unfair advantages\n• Attempt to modify game data or scores fraudulently\n\nViolation of fair play principles may result in the App being disabled on your device.',
        ),
        _TermsSection(
          title: '4. Intellectual Property',
          content:
              'All content within the App, including graphics, sounds, code, and design, is the intellectual property of the developer or its licensors. The Tetris game concept is used under appropriate licensing.\n\nYou may not reproduce, distribute, or create derivative works from any App content without prior written permission.',
        ),
        _TermsSection(
          title: '5. Disclaimer of Warranties',
          content:
              'The App is provided "as is" and "as available" without any warranties of any kind, either express or implied. We do not warrant that:\n\n• The App will be uninterrupted or error-free\n• Any defects will be corrected\n• The App is free of viruses or other harmful components\n\nYour use of the App is at your sole risk.',
        ),
        _TermsSection(
          title: '6. Limitation of Liability',
          content:
              'To the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of or inability to use the App, including but not limited to loss of data, loss of profits, or business interruption.',
        ),
        _TermsSection(
          title: '7. Updates and Modifications',
          content:
              'We reserve the right to update, modify, or discontinue the App at any time without notice. We may also update these Terms and Conditions. Continued use of the App after changes constitutes your acceptance of the new terms.\n\nWe recommend reviewing these Terms periodically for any updates.',
        ),
        _TermsSection(
          title: '8. Age Requirements',
          content:
              'The App is suitable for users of all ages. If you are under 13 years of age, please ensure a parent or legal guardian has reviewed and agreed to these Terms on your behalf.',
        ),
        _TermsSection(
          title: '9. Governing Law',
          content:
              'These Terms shall be governed by and construed in accordance with applicable laws. Any disputes arising from these Terms or your use of the App shall be resolved through good faith negotiation, and if necessary, through the appropriate legal channels.',
        ),
        _TermsSection(
          title: '10. Contact Information',
          content:
              'If you have any questions regarding these Terms and Conditions, please contact us. We are happy to address any concerns and work with you to resolve any issues related to your use of the App.',
        ),
        SizedBox(height: 32),
        _TermsFooter(),
      ],
    );
  }
}

class _PolicyHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String lastUpdated;

  const _PolicyHeader({
    required this.icon,
    required this.title,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kAccentDark, kAccentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lastUpdated,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kAccentColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kSurfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2A4A)),
            ),
            child: Text(
              content,
              style: const TextStyle(
                color: kTextSecondary,
                fontSize: 14,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsFooter extends StatelessWidget {
  const _TermsFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColor.withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.gavel_rounded, color: kPrimaryColor, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'By using this app, you acknowledge that you have read and agree to these Terms and Conditions.',
              style: TextStyle(
                color: kPrimaryLight,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
