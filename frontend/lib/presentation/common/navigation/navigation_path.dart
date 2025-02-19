import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';

class NavigationPath extends StatelessWidget {
  final List<String> paths;

  const NavigationPath({
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: TitleMedium(text: paths.last),
    );
  }
}
