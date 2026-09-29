import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../l10n/app_localizations.dart';

/// Shown after onboarding: a friendly welcome with two choices, create an
/// account or log in.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // TEMPORARY: both actions go to the developer home until the Sign Up and
  // Login screens are built in the authentication phase.
  void _goToSignUp(BuildContext context) => context.go(AppRoutes.dev);
  void _goToLogin(BuildContext context) => context.go(AppRoutes.dev);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Temporary illustration. It will be replaced by the real
              // taxi artwork later.
              Container(
                height: 260,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(AppIcons.taxi, size: 120, color: colors.primary),
                    PositionedDirectional(
                      top: 28,
                      end: 32,
                      child: Icon(
                        AppIcons.location,
                        size: 36,
                        color: colors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 28,
                      start: 32,
                      child: Icon(
                        AppIcons.destination,
                        size: 32,
                        color: colors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Text(
                l10n.welcomeTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.welcomeBody,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: l10n.welcomeCreateAccount,
                onPressed: () => _goToSignUp(context),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l10n.welcomeHaveAccount,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _goToLogin(context),
                    child: Text(l10n.welcomeLogin),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}