import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/utils/palette.dart';

class SecondaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final double? width;
  final bool enabled;

  const SecondaryTextButton({
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.width,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomInput.HEIGHT - 2,
      width: width,
      child: OutlinedButton.icon(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          foregroundColor:
              (color != null)
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.all(Palette.textTitle),
          backgroundColor: WidgetStateProperty.all(Palette.backgroundEmpty),
          side:
              (color != null)
                  ? WidgetStateProperty.all(BorderSide(color: color!))
                  : WidgetStateProperty.all(
                    const BorderSide(
                      width: 0.5,
                      color: Palette.borderButtonSecondary,
                    ),
                  ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: CustomInput.borderRadius),
          ),
        ),
        icon:
            (icon != null)
                ? Icon(icon!, color: color ?? Palette.textTitle)
                : null,
        label: Text(text),
      ),
    );
  }
}
