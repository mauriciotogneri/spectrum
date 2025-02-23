import 'package:flutter/material.dart';
import 'package:testflow/domain/types/test_run_result.dart';
import 'package:testflow/utils/palette.dart';

class LastResults extends StatelessWidget {
  final List<TestRunResult> results;

  const LastResults(this.results);

  @override
  Widget build(BuildContext context) {
    const double width = 250;
    const double height = 15;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        width: width + results.length - 1,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            for (int i = 0; i < results.length; i++) ...[
              if (i > 0)
                const VerticalDivider(
                  width: 0.5,
                  color: Palette.backgroundEmpty,
                ),
              Tooltip(
                message: results[i].localized,
                child: Container(
                  color: results[i].borderColor,
                  width: width / results.length,
                  height: height,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
