import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class MetadataCard extends StatelessWidget {
  final List<MetadataItem> items;

  const MetadataCard(this.items);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 350,
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : 16),
              child: MetadataRow(label: items[i].label, value: items[i].value),
            ),
        ],
      ),
    );
  }
}

class MetadataRow extends StatelessWidget {
  final String label;
  final String value;

  const MetadataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 150,
          child: CustomText(
            text: label,
            size: 14,
            color: Palette.textTitle,
            weight: FontWeight.bold,
          ),
        ),
        CustomText(
          text: value,
          size: 14,
          color: Palette.textBody,
          weight: FontWeight.normal,
        ),
      ],
    );
  }
}

class MetadataItem {
  final String label;
  final String value;

  const MetadataItem({required this.label, required this.value});
}
