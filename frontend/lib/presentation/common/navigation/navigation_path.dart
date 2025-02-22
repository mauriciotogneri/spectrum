import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class NavigationPath extends StatelessWidget {
  final List<String> paths;

  const NavigationPath({required this.paths});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.backgroundNavigationPath,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < paths.length; i++)
            PathSection(
              text: paths[i],
              isLast: i == paths.length - 1,
              unstack: paths.length - i - 1,
            ),
        ],
      ),
    );
  }
}

class PathSection extends StatelessWidget {
  final String text;
  final bool isLast;
  final int unstack;

  const PathSection({
    required this.text,
    required this.isLast,
    required this.unstack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {}, //isLast ? null : () => Navigation.unstack(unstack),
      child: Row(
        children: [
          const HBox(12),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CustomText(
              text: text,
              color: Palette.textTitle,
              size: 14,
              weight: isLast ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const HBox(12),
          if (!isLast)
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Palette.textTitle,
            ),
        ],
      ),
    );
  }
}
