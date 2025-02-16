import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/utils/palette.dart';

class CustomTable<T extends CustomTableCell> extends StatelessWidget {
  final List<CustomTableColumn> columns;
  final List<T> rows;
  final Function(T) onRowSelected;
  final double? width;

  const CustomTable({
    required this.columns,
    required this.rows,
    required this.onRowSelected,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Palette.backgroundEmpty,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        border: Border(
          top: BorderSide(color: Palette.borderTable, width: 0.5),
          left: BorderSide(color: Palette.borderTable, width: 0.5),
          right: BorderSide(color: Palette.borderTable, width: 0.5),
        ),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        child: Placeholder(),
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

class CustomTableColumn {
  final String name;
  final double ratio;
  final Alignment? alignment;

  const CustomTableColumn({
    required this.name,
    required this.ratio,
    this.alignment,
  });
}
