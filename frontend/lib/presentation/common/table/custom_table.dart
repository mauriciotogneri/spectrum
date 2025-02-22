import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_icon_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

/*
  Use LinearProgressIndicator when loading elements
*/
class CustomTable<T extends TableElement> extends StatelessWidget {
  final List<TableColumn> columns;
  final List<T> rows;
  final Function(T) onSelected;
  final List<Widget> filters;
  final double? width;
  final VoidCallback? onResetFilters;
  final VoidCallback? onCreateItem;

  const CustomTable({
    required this.columns,
    required this.rows,
    required this.onSelected,
    this.filters = const [],
    this.width,
    this.onResetFilters,
    this.onCreateItem,
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
              FilterRow(
                filters: filters,
                onResetFilters: onResetFilters,
                onCreateItem: onCreateItem,
              ),
              HeaderRow(columns),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              ItemRows(columns: columns, rows: rows, onSelected: onSelected),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              FooterRow(rows.length),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  final List<Widget> filters;
  final VoidCallback? onResetFilters;
  final VoidCallback? onCreateItem;

  const FilterRow({
    required this.filters,
    required this.onResetFilters,
    required this.onCreateItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 8, right: 8),
      color: Palette.backgroundTableHeader,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...filters,
          const HBox(8),
          if (onResetFilters != null) ...[
            ResetFiltersButton(onResetFilters),
            const HBox(8),
          ],
          const Spacer(),
          const HBox(8),
          TableSelectColumns(() {}),
          const HBox(8),
          TableExportButton(() {}),
          const HBox(8),
          TableCreateAction(text: 'Create', onPressed: onCreateItem),
        ],
      ),
    );
  }
}

class ResetFiltersButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ResetFiltersButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SecondaryTextButton(
      icon: Icons.clear,
      onPressed: onPressed,
      color: Palette.textSecondary,
      text: 'Reset',
    );
  }
}

class TableSelectColumns extends StatelessWidget {
  final VoidCallback? onPressed;

  const TableSelectColumns(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SecondaryIconButton(
      icon: Icons.checklist_rounded,
      onPressed: onPressed,
    );
  }
}

class TableExportButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const TableExportButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SecondaryIconButton(
      icon: Icons.file_download_outlined,
      onPressed: onPressed,
    );
  }
}

class TableCreateAction extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const TableCreateAction({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PrimaryTextButton(icon: Icons.add, text: text, onPressed: onPressed);
  }
}

class HeaderRow extends StatelessWidget {
  final List<TableColumn> columns;

  const HeaderRow(this.columns);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Palette.backgroundTableHeader,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
        color: Palette.textBody,
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
    final Widget widget = Container(
      width: width,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: content,
      ),
    );

    return (width != null) ? widget : Expanded(child: widget);
  }
}

class FooterRow extends StatelessWidget {
  final int total;

  const FooterRow(this.total);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundTableHeader,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          FooterTotal(total),
          const Spacer(),
          FooterButton(
            icon: Icons.keyboard_arrow_left_rounded,
            onPressed: () {},
          ),
          const HBox(8),
          FooterButton(
            icon: Icons.keyboard_arrow_right_rounded,
            onPressed: () {},
          ),
          const HBox(8),
        ],
      ),
    );
  }
}

class FooterTotal extends StatelessWidget {
  final int total;

  const FooterTotal(this.total);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: CustomText(
            text: 'Total: $total',
            color: Palette.textTitle,
            size: 14,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class FooterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FooterButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: 34,
        height: 34,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.only(left: 6)),
            foregroundColor: WidgetStateProperty.all(Palette.textSecondary),
            side: WidgetStateProperty.all(
              const BorderSide(color: Palette.borderButtonSecondary),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: CustomInput.borderRadius),
            ),
          ),
          icon: Icon(icon, color: Palette.iconEnabled, size: 20),
          label: const Empty(),
        ),
      ),
    );
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
