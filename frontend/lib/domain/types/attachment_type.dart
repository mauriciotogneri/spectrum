import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';

enum AttachmentType implements Chipable {
  text,
  image,
  video,
  audio,
  document,
  other;

  String get localized {
    switch (this) {
      case AttachmentType.text:
        return 'Text';
      case AttachmentType.image:
        return 'Image';
      case AttachmentType.video:
        return 'Video';
      case AttachmentType.audio:
        return 'Audio';
      case AttachmentType.document:
        return 'Document';
      case AttachmentType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case AttachmentType.text:
        return Icons.notes;
      case AttachmentType.image:
        return Icons.photo_camera_outlined;
      case AttachmentType.video:
        return Icons.videocam_outlined;
      case AttachmentType.audio:
        return Icons.music_note;
      case AttachmentType.document:
        return Icons.description_outlined;
      case AttachmentType.other:
        return Icons.attachment_outlined;
    }
  }

  @override
  CustomChip get chip => CustomChip(text: localized);

  static List<DropdownItem<AttachmentType>> get items =>
      AttachmentType.values
          .map((type) => DropdownItem(value: type, text: type.localized))
          .toList();

  @override
  String toString() => localized;
}
