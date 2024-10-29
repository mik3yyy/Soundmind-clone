import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.fillColor,
      this.keyboardType,
      this.obscureText = false,
      this.maxLength,
      this.maxLines,
      this.errorText,
      this.onChanged,
      this.textAlign,
      this.minLines,
      this.prefix,
      this.enabled,
      this.borderColor,
      this.onTap,
      this.labelText,
      this.radius = 6,
      this.focusNode,
      this.titleText,
      this.onEditingComplete,
      this.validator,
      this.expands = false,
      this.textInputAction,
      this.isPasswordField = false});
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  final String hintText;
  final String? titleText;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;

  final bool expands;
  final bool? enabled;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final int? maxLength;
  final double radius;
  final int? maxLines;

  final int? minLines;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final bool isPasswordField;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText != null) ...[
            AutoSizeText(
              widget.titleText!,
              style: context.textTheme.bodyMedium,
            ),
            const Gap(5),
          ],
          TextFormField(
            enabled: widget.enabled,
            controller: widget.controller,
            textAlign: widget.textAlign ?? TextAlign.start,

            // cursorHeight: 17,

            keyboardType: widget.keyboardType,
            obscureText: widget.isPasswordField ? visible : widget.obscureText,
            cursorColor: context.colors.black,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines ?? 1,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            expands: widget.expands,

            onEditingComplete: widget.onEditingComplete,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              fillColor: widget.fillColor ?? context.colors.greyOutline,
              filled: true, // widget.fillColor != null,
              labelText: widget.labelText,
              errorText: widget.errorText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                  color: widget.controller.text.isEmpty
                      ? context.colors.greyOutline
                      : widget.borderColor ?? context.colors.greyOutline,
                ),
                gapPadding: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                  color: widget.borderColor ?? context.colors.greyOutline,
                ),
                gapPadding: 0,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                  color: widget.borderColor ?? context.colors.greyOutline,
                ),
                gapPadding: 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                  color: widget.borderColor ?? context.colors.greyOutline,
                ),
                gapPadding: 0,
              ),

              hintText:
                  widget.isPasswordField ? "Enter password" : widget.hintText,
              hintStyle: context.textTheme.bodyMedium
                  ?.copyWith(color: context.colors.black),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: visible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))
                  : widget.suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
