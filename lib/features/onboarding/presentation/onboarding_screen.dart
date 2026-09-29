import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../l10n/app_localizations.dart';

/// Three introduction pages shown to a new user: swipe or tap "Next",
/// or "Skip" at any time. Works in both LTR (English) and RTL (Dari,
/// Pashto): the pages swipe in the reading direction automatically.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _pageCount = 3;

  final PageController _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _pageCount - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() {
    context.go(AppRoutes.welcome);
  }

  void _next() {
    if (_isLast) {
      _finish();
      return;
    }
    if (MediaQuery.of(context).disableAnimations) {
      _controller.jumpToPage(_index + 1);
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    final pages = [
      (AppIcons.taxi, l10n.onboarding1Title, l10n.onboarding1Body),
      (AppIcons.safety, l10n.onboarding2Title, l10n.onboarding2Body),
      (AppIcons.cash, l10n.onboarding3Title, l10n.onboarding3Body),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (hidden on the last page, but keeps its space).
            SizedBox(
              height: 56,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: _isLast
                      ? null
                      : TextButton(
                          onPressed: _finish,
                          child: Text(l10n.onboardingSkip),
                        ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageCount,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) => _OnboardingPage(
                  icon: pages[i].$1,
                  title: pages[i].$2,
                  body: pages[i].$3,
                ),
              ),
            ),
            // Page dots.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pageCount; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: i == _index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: i == _index ? colors.primary : colors.outline,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: PrimaryButton(
                label: _isLast
                    ? l10n.onboardingGetStarted
                    : l10n.onboardingNext,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Temporary illustration: icon on a soft circle. It will be
            // replaced by the real taxi artwork later.
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 88, color: colors.primary),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
