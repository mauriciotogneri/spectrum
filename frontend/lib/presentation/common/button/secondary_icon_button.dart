import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/utils/palette.dart';

class SecondaryIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? iconSize;
  final double size;
  final bool enabled;

  const SecondaryIconButton({
    required this.icon,
    this.onPressed,
    this.color,
    this.iconSize,
    this.size = CustomInput.HEIGHT - 2,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: OutlinedButton(
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
                    const BorderSide(color: Palette.borderButtonSecondary),
                  ),
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: CustomInput.borderRadius),
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: color ?? Palette.textTitle,
            size: iconSize ?? size / 2.5,
          ),
        ),
      ),
    );
  }
}
