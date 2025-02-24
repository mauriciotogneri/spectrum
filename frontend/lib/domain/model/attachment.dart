import 'package:flutter/material.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/formatter.dart';
import 'package:testflow/utils/palette.dart';

class Attachment
    implements TableElement<Attachment, AttachmentColumn, AttachmentMenu> {
  final String path;
  final String name;
  final String url;
  final AttachmentType type;
  final int size;
  final DateTime uploadedOn;
  final String uploadedBy;

  const Attachment({
    required this.path,
    required this.name,
    required this.url,
    required this.type,
    required this.size,
    required this.uploadedOn,
    required this.uploadedBy,
  });

  bool matches({
    required String queryFilter,
    required List<AttachmentType> typeFilter,
  }) {
    if (queryFilter.isEmpty && typeFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery =
          queryFilter.isEmpty || name.matches(queryFilter);
      final bool matchesType = typeFilter.isEmpty || typeFilter.contains(type);

      return matchesQuery && matchesType;
    }
  }

  static List<TableColumn<AttachmentColumn>> get columns => const [
    TableColumn(id: AttachmentColumn.icon, name: '', width: 30),
    TableColumn(id: AttachmentColumn.name, name: 'Name'),
    TableColumn(
      id: AttachmentColumn.type,
      name: 'Type',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: AttachmentColumn.size,
      name: 'Size',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: AttachmentColumn.uploadedOn,
      name: 'Uploaded on',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: AttachmentColumn.uploadedBy,
      name: 'Uploaded by',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: AttachmentColumn.menu,
      name: '',
      width: 100,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell({
    required TableColumn<AttachmentColumn> column,
    required Function(Attachment, AttachmentMenu)? onMenuSelected,
  }) {
    switch (column.id) {
      case AttachmentColumn.icon:
        return Icon(type.icon, size: 16, color: Palette.textBody);
      case AttachmentColumn.name:
        return BodyMedium(text: name);
      case AttachmentColumn.type:
        return type.chip;
      case AttachmentColumn.size:
        return BodyMedium(text: Formatter.fileSize(size));
      case AttachmentColumn.uploadedOn:
        return Tooltip(
          message: Formatter.fullDateTime(uploadedOn),
          child: BodyMedium(text: Formatter.dateMonthYear(uploadedOn)),
        );
      case AttachmentColumn.uploadedBy:
        return BodyMedium(text: uploadedBy);
      case AttachmentColumn.menu:
        return ContextMenu(
          offset: const Offset(-85, 0),
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.file_download_outlined,
              text: 'Download',
              color: Palette.textTitle,
              onPressed:
                  () => onMenuSelected?.call(this, AttachmentMenu.download),
            ),
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed:
                  () => onMenuSelected?.call(this, AttachmentMenu.delete),
            ),
          ],
        );
    }
  }
}

enum AttachmentColumn { icon, name, type, size, uploadedOn, uploadedBy, menu }

enum AttachmentMenu { download, delete }
