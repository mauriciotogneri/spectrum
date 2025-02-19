import 'package:dafluta/dafluta.dart';
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

class ChipGroup<T> extends StatelessWidget {
  final List<T> items;
  final String plural;

  const ChipGroup({required this.items, required this.plural});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Empty();
    } else if (items.length == 1) {
      return CustomChip(text: items.first.toString());
    } else {
      return CustomChip(text: '${items.length} $plural');
    }
  }
}
