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
              HeaderRow(columns),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              ItemRows(columns: columns, rows: rows, onSelected: onSelected),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final List<TableColumn> columns;

  const HeaderRow(this.columns);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundTableHeader,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final TableColumn column in columns) HeaderCell(column),
        ],
      ),
    );
  }
}

class HeaderCell extends StatelessWidget {
  final TableColumn column;

  const HeaderCell(this.column);

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

class ItemRows<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final List<T> rows;
  final Function(T) onSelected;

  const ItemRows({
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
        for (int i = 0; i < rows.length; i++)
          ItemRow(
            columns: columns,
            row: rows[i],
            index: i,
            onSelected: onSelected,
          ),
      ],
    );
  }
}

class ItemRow<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final T row;
  final int index;
  final Function(T) onSelected;

  const ItemRow({
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
    final Widget widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: width,
        height: 40,
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: content,
        ),
      ),
    );

    return (width != null) ? widget : Expanded(child: widget);
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
