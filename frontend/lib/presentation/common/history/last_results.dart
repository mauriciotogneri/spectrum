import 'package:flutter/material.dart';
import 'package:testflow/domain/types/test_run_status.dart';

class LastResults extends StatelessWidget {
  final List<TestRunStatus> results;

  const LastResults(this.results);

  @override
  Widget build(BuildContext context) {
    const double width = 250;
    const double height = 15;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            for (final result in results)
              Tooltip(
                message: result.localized,
                child: Container(
                  color: result.foregroundColor,
                  width: width / results.length,
                  height: height,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
