import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/utils/palette.dart';

enum AttachmentType {
  text,
  image,
  video,
  audio,
  pdf,
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
      case AttachmentType.pdf:
        return 'PDF';
      case AttachmentType.other:
        return 'Other';
    }
  }

  CustomChip get chip => CustomChip(
    text: localized,
    backgroundColor: Palette.chipGreyBackground,
    foregroundColor: Palette.chipGreyForeground,
  );

  static List<DropdownItem<AttachmentType>> get items =>
      AttachmentType.values
          .map((type) => DropdownItem(value: type, text: type.localized))
          .toList();

  @override
  String toString() => localized;
}
