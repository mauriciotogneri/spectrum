import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/utils/palette.dart';

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final double? width;
  final bool enabled;
  final bool loading;

  const PrimaryTextButton({
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.width,
    this.enabled = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomInput.HEIGHT - 2,
      width: width,
      child: FilledButton.icon(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor:
              (color != null) ? WidgetStateProperty.all(color) : null,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: CustomInput.borderRadius),
          ),
        ),
        icon: _icon,
        label: Text(text),
      ),
    );
  }

  Widget? get _icon {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.only(right: 4),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Palette.iconLoader),
          ),
        ),
      );
    } else {
      return icon != null ? Icon(icon) : null;
    }
  }
}
