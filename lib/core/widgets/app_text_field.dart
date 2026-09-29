import 'package:flutter/material.dart';

import '../constants/app_icons.dart';

/// The standard text input of the app.
///
/// Look comes from the theme (`AppTheme`). Features:
/// - [obscureText]: password field with a show/hide eye button
/// - [forceLtr]: keeps numbers such as phone numbers left-to-right even
///   when the app language is Dari or Pashto (RTL)
/// - [errorText]: shows a clear error message under the field
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.forceLtr = false,
    this.enabled = true,
    this.maxLength,
    this.onChanged,
    this.toggleTooltip,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool forceLtr;
  final bool enabled;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  /// Accessibility text of the show/hide password button.
  /// Pass a localized string.
  final String? toggleTooltip;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hidden = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _hidden,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      textDirection: widget.forceLtr ? TextDirection.ltr : null,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.errorText,
        counterText: '',
        prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        suffixIcon: widget.obscureText
            ? IconButton(
                tooltip: widget.toggleTooltip,
                icon: Icon(
                  _hidden ? AppIcons.visibility : AppIcons.visibilityOff,
                ),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );
  }
}
