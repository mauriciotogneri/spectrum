import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final double? size;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const CustomChip({
    required this.text,
    this.size,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double chipSize = size ?? 12;
    final Color chipForegroundColor =
        foregroundColor ?? Palette.chipGreyForeground;
    final Color chipBackgroundColor =
        backgroundColor ?? Palette.chipGreyBackground;

    return Container(
      decoration: BoxDecoration(
        color: chipBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: chipSize / 4,
          bottom: chipSize / 4,
          left: chipSize,
          right: chipSize,
        ),
        child: CustomText(
          text: text,
          color: chipForegroundColor,
          size: chipSize,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ChipRow<T> extends StatelessWidget {
  final List<T> chips;
  final double? size;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const ChipRow({
    required this.chips,
    this.size,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final T chip in chips)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CustomChip(
              text: chip.toString(),
              size: size,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
            ),
          ),
      ],
    );
  }
}
