import 'package:flutter/material.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.textStyle});
  final VoidCallback onPressed;
  final String label;
  final TextStyle? textStyle;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.label,
        style: widget.textStyle ?? context.textTheme.titleMedium,
      ),
    );
  }
}
