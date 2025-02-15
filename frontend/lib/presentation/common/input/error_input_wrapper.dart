import 'package:flutter/widgets.dart';
import 'package:testflow/presentation/common/text/body_small.dart';
import 'package:testflow/utils/palette.dart';

class ErrorInputWrapper extends StatelessWidget {
  final Widget child;
  final String? error;

  const ErrorInputWrapper({required this.child, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: BodySmall(text: error!, color: Palette.textError),
          ),
      ],
    );
  }
}
