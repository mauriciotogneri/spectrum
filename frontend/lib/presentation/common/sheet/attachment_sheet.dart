import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/icon/input_icon.dart';
import 'package:testflow/presentation/common/sheet/custom_sheet.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/palette.dart';

class AttachmentSheet extends StatelessWidget {
  final VoidCallback onOpen;
  final VoidCallback onDownload;
  final VoidCallback onDelete;

  const AttachmentSheet._({
    required this.onOpen,
    required this.onDownload,
    required this.onDelete,
  });

  static DialogController show({
    required BuildContext context,
    required VoidCallback onOpen,
    required VoidCallback onDownload,
    required VoidCallback onDelete,
  }) => CustomBottomSheet.show(
    context: context,
    child: AttachmentSheet._(
      onOpen: onOpen,
      onDownload: onDownload,
      onDelete: onDelete,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const InputIcon(
              icon: Icons.remove_red_eye_outlined,
              size: 20,
            ),
            title: const BodyMedium(text: 'Open'),
            horizontalTitleGap: 16,
            onTap: () {
              Navigator.of(context).pop();
              onOpen();
            },
          ),
          ListTile(
            leading: const InputIcon(icon: Icons.download, size: 20),
            title: const BodyMedium(text: 'Download'),
            horizontalTitleGap: 16,
            onTap: () {
              Navigator.of(context).pop();
              onDownload();
            },
          ),
          ListTile(
            leading: const InputIcon(
              icon: Icons.delete_outline,
              size: 20,
              color: Palette.semanticError,
            ),
            title: const BodyMedium(
              text: 'Delete',
              color: Palette.semanticError,
            ),
            horizontalTitleGap: 16,
            onTap: () {
              Navigator.of(context).pop();
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
