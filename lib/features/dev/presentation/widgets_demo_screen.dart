import 'package:flutter/material.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';

/// TEMPORARY developer screen that shows every reusable widget in one place.
/// It is deleted before release. Texts here are not localized on purpose.
class WidgetsDemoScreen extends StatelessWidget {
  const WidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget section(String title) => Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(title, style: textTheme.titleMedium),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Widgets demo')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            section('Buttons'),
            PrimaryButton(
              label: 'Request taxi',
              icon: AppIcons.taxi,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              label: 'Cancel',
              icon: AppIcons.close,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            PrimaryButton(label: 'Loading', isLoading: true, onPressed: () {}),
            const SizedBox(height: 12),
            const PrimaryButton(label: 'Disabled', onPressed: null),
            section('Text fields'),
            const AppTextField(
              label: 'Full name',
              prefixIcon: AppIcons.profile,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            const AppTextField(
              label: 'Phone number',
              hint: '70 123 4567',
              prefixIcon: AppIcons.phone,
              keyboardType: TextInputType.phone,
              forceLtr: true,
              errorText: 'Invalid phone number',
            ),
            const SizedBox(height: 12),
            const AppTextField(
              label: 'Password',
              prefixIcon: AppIcons.lock,
              obscureText: true,
              toggleTooltip: 'Show or hide password',
            ),
            section('Loading'),
            const SizedBox(
              height: 140,
              child: LoadingWidget(message: 'Loading...'),
            ),
            section('Empty state'),
            SizedBox(
              height: 340,
              child: EmptyState(
                title: 'No trips yet',
                message: 'Your completed trips will appear here.',
                actionLabel: 'Book a taxi',
                onAction: () {},
              ),
            ),
            section('Error state'),
            SizedBox(
              height: 340,
              child: ErrorState(
                title: 'No internet connection',
                message: 'Please check your connection and try again.',
                retryLabel: 'Try again',
                onRetry: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
