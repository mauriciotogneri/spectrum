import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class CustomTable<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final List<T> rows;
  final Function(T) onSelected;
  final double? width;

  const CustomTable({
    required this.columns,
    required this.rows,
    required this.onSelected,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backgroundEmpty,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: Palette.borderInputEnabled, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ColumnsHeader(columns),
            RowsList(columns: columns, rows: rows, onSelected: onSelected),
          ],
        ),
      ),
    );
  }
}

class ColumnsHeader extends StatelessWidget {
  final List<TableColumn> columns;

  const ColumnsHeader(this.columns);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for (final TableColumn column in columns) ColumnCell(column)],
    );
  }
}

class ColumnCell extends StatelessWidget {
  final TableColumn column;

  const ColumnCell(this.column);

  @override
  Widget build(BuildContext context) {
    final Widget widget = Container(
      color: Palette.backgroundTableHeader,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: CustomText(
          text: column.name,
          color: Palette.textTitle,
          size: 14,
          weight: FontWeight.w500,
        ),
      ),
    );

    if (column.width != null) {
      return SizedBox(width: column.width, child: widget);
    } else {
      return Expanded(child: widget);
    }
  }
}

class RowsList<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final List<T> rows;
  final Function(T) onSelected;

  const RowsList({
    required this.columns,
    required this.rows,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final T row in rows) RowContent(columns: columns, row: row),
      ],
    );
  }
}

class RowContent<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final T row;

  const RowContent({required this.columns, required this.row});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (final TableColumn column in columns)
          RowCell(column: column, content: row.cell(column)),
      ],
    );
  }
}

class RowCell extends StatelessWidget {
  final TableColumn column;
  final Widget content;

  const RowCell({required this.column, required this.content});

  @override
  Widget build(BuildContext context) {
    final Widget widget = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: content,
    );

    if (column.width != null) {
      return SizedBox(width: column.width, child: widget);
    } else {
      return Expanded(child: widget);
    }
  }
}

class TableColumn<T> {
  final T id;
  final String name;
  final double? width;
  final Alignment? alignment;

  const TableColumn({
    required this.id,
    required this.name,
    this.width,
    this.alignment,
  });
}

class TableCell {
  final TableColumn column;
  final Widget content;

  const TableCell({required this.column, required this.content});
}

abstract class TableElement {
  Widget cell(TableColumn column);
}
