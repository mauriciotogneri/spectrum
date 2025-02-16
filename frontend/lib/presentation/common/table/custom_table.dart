import 'package:flutter/material.dart';
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
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ColumnsHeader(columns),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              RowsList(columns: columns, rows: rows, onSelected: onSelected),
            ],
          ),
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
    return Container(
      color: Palette.backgroundTableHeader,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final TableColumn column in columns) ColumnCell(column),
        ],
      ),
    );
  }
}

class ColumnCell extends StatelessWidget {
  final TableColumn column;

  const ColumnCell(this.column);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      content: CustomText(
        text: column.name,
        color: Palette.textTitle,
        size: 14,
        weight: FontWeight.w500,
      ),
      width: column.width,
      alignment: column.alignment,
    );
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
      children: [
        for (int i = 0; i < rows.length; i++)
          RowContent(
            columns: columns,
            row: rows[i],
            index: i,
            onSelected: onSelected,
          ),
      ],
    );
  }
}

class RowContent<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final T row;
  final int index;
  final Function(T) onSelected;

  const RowContent({
    required this.columns,
    required this.row,
    required this.index,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          (index % 2 == 0)
              ? Palette.backgroundRowEven
              : Palette.backgroundRowOdd,
      child: InkWell(
        onTap: () => onSelected(row),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final TableColumn column in columns)
                TableCell(
                  content: row.cell(column),
                  width: column.width,
                  alignment: column.alignment,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  final Widget content;
  final double? width;
  final Alignment? alignment;

  const TableCell({required this.content, this.width, this.alignment});

  @override
  Widget build(BuildContext context) {
    final Widget widget = SizedBox(
      width: width,
      height: 40,
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: content,
      ),
    );

    if (width != null) {
      return widget;
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

abstract class TableElement {
  Widget cell(TableColumn column);
}
