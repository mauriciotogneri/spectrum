import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet({required this.child});

  static DialogController show({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.transparent,
      builder: (context) => child,
    );

    return DialogController(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Palette.backgroundEmpty,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Material(
          color: Palette.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Palette.borderInputEnabled,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ),
              const VBox(10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
