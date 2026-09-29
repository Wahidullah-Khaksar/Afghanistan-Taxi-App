import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/presentation/providers/locale_provider.dart';
import '../../settings/presentation/providers/theme_mode_provider.dart';

/// Temporary screen. It proves that the architecture, localization, RTL,
/// light/dark themes and the reusable widgets work.
/// The real animated splash is built in Phase 4.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(AppIcons.taxi, size: 72, color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  l10n.appName,
                  style: textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.splashTagline,
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(l10n.phaseOneReady, style: textTheme.titleMedium),
                const SizedBox(height: 32),
                Text(l10n.chooseLanguage, style: textTheme.labelLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final language in AppConfig.languages)
                      ChoiceChip(
                        label: Text(language.nativeName),
                        selected: currentLocale == language.locale,
                        onSelected: (_) => ref
                            .read(localeProvider.notifier)
                            .setLocale(language.locale),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                // Temporary switch to test the dark theme. The real,
                // localized version belongs to the Settings screen.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(AppIcons.darkMode),
                    const SizedBox(width: 8),
                    Switch(
                      value: isDark,
                      onChanged: (value) => ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(
                            value ? ThemeMode.dark : ThemeMode.light,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // TEMPORARY button that opens the developer widgets screen.
                SecondaryButton(
                  label: 'Widgets demo',
                  icon: AppIcons.settings,
                  onPressed: () => context.push(AppRoutes.widgetsDemo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
