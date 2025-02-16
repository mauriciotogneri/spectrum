import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class CustomTable<T extends CustomTableCell> extends StatelessWidget {
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
          children: [ColumnsHeader(columns)],
        ),
        /*ShadTable(
            columnCount: columns.length,
            rowCount: rows.length,
            header:
                (context, index) => ShadTableCell.header(
                  child: BodyMedium(
                    text: columns[index].name,
                  ),
                ),
            columnSpanExtent:
                (index) => FractionalSpanExtent(columns[index].ratio),
            onRowTap: (index) {
              if (index > 0) {
                onRowSelected(rows[index - 1]);
              }
            },
            rowSpanBackgroundDecoration:
                (row) =>
                    row == 0
                        ? const SpanDecoration(
                          border: SpanBorder(
                            trailing: BorderSide(
                              width: 0.5,
                              color: Palette.borderTable,
                            ),
                          ),
                          color: Palette.backgroundTableHeader,
                        )
                        : null,
            builder:
                (context, index) => ShadTableCell(
                  alignment: columns[index.column].alignment,
                  child: rows[index.row].cell(index.column),
                ),
          ),*/
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
      children: [for (final column in columns) ColumnCell(column)],
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

class TableColumn {
  final String name;
  final double? width;
  final Alignment? alignment;

  const TableColumn({required this.name, this.width, this.alignment});
}
