import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final double? size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const CustomChip({
    required this.text,
    this.size,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final double chipSize = size ?? 12;
    final Color chipForegroundColor =
        foregroundColor ?? Palette.chipWhiteForeground;
    final Color chipBackgroundColor =
        backgroundColor ?? Palette.chipWhiteBackground;
    final Color chipBorderColor = borderColor ?? Palette.chipWhiteBorder;

    return Container(
      decoration: BoxDecoration(
        color: chipBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: chipBorderColor, width: 0.5),
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

class ChipGroup<T> extends StatelessWidget {
  final List<T> items;
  final String plural;

  const ChipGroup({required this.items, required this.plural});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Empty();
    } else if (items.length == 1) {
      final T item = items.first;

      if (item is Chipable) {
        return item.chip;
      } else {
        return CustomChip(text: item.toString());
      }
    } else {
      return Tooltip(
        message: items.join('\n'),
        textAlign: TextAlign.center,
        child: CustomChip(
          text: '${items.length} $plural',
          backgroundColor: Palette.chipGreyBackground,
          foregroundColor: Palette.chipGreyForeground,
          borderColor: Palette.chipGreyBorder,
        ),
      );
    }
  }
}

abstract class Chipable {
  CustomChip get chip;
}
