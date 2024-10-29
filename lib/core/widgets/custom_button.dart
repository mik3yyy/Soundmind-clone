import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final ValueNotifier<bool>? notifier;
  final bool enable;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final BoxBorder? border;
  final TextStyle? style;
  final Widget? titleWidget;
  final bool isshadow;

  const CustomButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.notifier,
      this.enable = true,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.textSize,
      this.border,
      this.style,
      this.titleWidget,
      this.isshadow = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier ?? ValueNotifier(false),
      builder: (BuildContext context, value, Widget? child) {
        return Opacity(
          opacity: value || !widget.enable ? 0.5 : 1,
          child: MaterialButton(
            padding: EdgeInsets.zero,
            highlightColor: context.colors.white,
            splashColor: Colors.transparent,
            onPressed:
                value || widget.enable == false ? () {} : widget.onPressed,
            child: Container(
              width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
              height: widget.height ?? 55,
              decoration: BoxDecoration(
                color: widget.enable
                    ? widget.color ?? context.primaryColor
                    : const Color(0xFFE3E4E8),
                borderRadius: BorderRadius.circular(36),
                border: widget.border,
                boxShadow: widget.isshadow
                    ? [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 23,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Stack(
                children: [
                  Center(
                    child: widget.titleWidget ??
                        Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: widget.style ??
                              TextStyle(
                                color: widget.enable
                                    ? widget.textColor ?? context.colors.white
                                    : const Color(0xFF8692A6),
                                fontWeight: FontWeight.w500,
                                fontSize: widget.textSize ?? 16,
                              ),
                        ),
                  ),
                  if (value)
                    Positioned(
                        right: 10,
                        top: 56 / 4,
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Theme.of(context).colorScheme.secondary,
                          rightDotColor: context.colors.black,
                          size: 20,
                        )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
