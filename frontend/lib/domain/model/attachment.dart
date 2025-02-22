import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/formatter.dart';

class Attachment implements TableElement {
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

  static List<TableColumn> get columns => const [
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
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case AttachmentColumn.name:
        return BodyMedium(text: name);
      case AttachmentColumn.type:
        return type.chip;
      case AttachmentColumn.size:
        return BodyMedium(text: Formatter.fileSize(size));
      case AttachmentColumn.uploadedOn:
        return BodyMedium(text: Formatter.fullDateTime(uploadedOn));
      case AttachmentColumn.uploadedBy:
        return BodyMedium(text: uploadedBy);
      default:
        return const Empty();
    }
  }
}

enum AttachmentColumn { name, type, size, uploadedOn, uploadedBy }
