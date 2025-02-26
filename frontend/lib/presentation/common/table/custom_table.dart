import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_icon_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

// TODO(momo): Use LinearProgressIndicator when loading elements
class CustomTable<E extends TableElement<E, C, M>, C, M>
    extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final List<E> rows;
  final Function(E) onSelected;
  final List<Widget> filters;
  final double? width;
  final VoidCallback? onResetFilters;
  final VoidCallback? onCreateItem;
  final String? createButtonText;
  final IconData? createButtonIcon;
  final Function(E, M)? onMenuSelected;

  const CustomTable({
    required this.columns,
    required this.rows,
    required this.onSelected,
    this.filters = const [],
    this.width,
    this.onResetFilters,
    this.onCreateItem,
    this.createButtonText,
    this.createButtonIcon,
    this.onMenuSelected,
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
                columns: columns,
                filters: filters,
                onResetFilters: onResetFilters,
                onCreateItem: onCreateItem,
                createButtonText: createButtonText,
                createButtonIcon: createButtonIcon,
              ),
              HeaderRow(columns),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              ItemRows(
                columns: columns,
                rows: rows,
                onSelected: onSelected,
                onMenuSelected: onMenuSelected,
              ),
              const Divider(height: 1, color: Palette.borderInputEnabled),
              FooterRow(rows.length),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterRow<C> extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final List<Widget> filters;
  final VoidCallback? onResetFilters;
  final VoidCallback? onCreateItem;
  final String? createButtonText;
  final IconData? createButtonIcon;

  const FilterRow({
    required this.columns,
    required this.filters,
    required this.onResetFilters,
    required this.onCreateItem,
    required this.createButtonText,
    required this.createButtonIcon,
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
          TableSelectColumns(columns: columns, onPressed: () {}),
          const HBox(8),
          TableSortColumns(columns: columns, onPressed: () {}),
          const HBox(8),
          TableExportButton(() {}),
          if (onCreateItem != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TableCreateAction(
                text: createButtonText ?? 'Create',
                icon: createButtonIcon ?? Icons.add,
                onPressed: onCreateItem,
              ),
            ),
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
      icon: Icons.replay,
      onPressed: onPressed,
      text: 'Reset',
    );
  }
}

class TableSelectColumns<C> extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final VoidCallback? onPressed;

  const TableSelectColumns({required this.columns, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Columns',
      child: ContextMenu(
        type: ContextButton.secondary,
        icon: Icons.tune,
        children: [
          for (final TableColumn<C> column in columns)
            if (column.name.isNotEmpty)
              ContextMenuItem(
                icon: Icons.check,
                iconSize: 14,
                text: column.name,
                color: Palette.textTitle,
                onPressed: () {},
              ),
        ],
      ),
    );
  }
}

class TableSortColumns<C> extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final VoidCallback? onPressed;

  const TableSortColumns({required this.columns, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sort',
      child: ContextMenu(
        type: ContextButton.secondary,
        icon: Icons.swap_vert,
        children: [
          for (final TableColumn<C> column in columns)
            if (column.name.isNotEmpty)
              ContextMenuItem(
                text: column.name,
                color: Palette.textTitle,
                onPressed: () {},
              ),
        ],
      ),
    );
  }
}

class TableExportButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const TableExportButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Export',
      child: SecondaryIconButton(
        icon: Icons.file_download_outlined,
        onPressed: onPressed,
      ),
    );
  }
}

class TableCreateAction extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const TableCreateAction({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryTextButton(icon: icon, text: text, onPressed: onPressed);
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

class ItemRows<E extends TableElement<E, C, M>, C, M> extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final List<E> rows;
  final Function(E) onSelected;
  final Function(E, M)? onMenuSelected;

  const ItemRows({
    required this.columns,
    required this.rows,
    required this.onSelected,
    required this.onMenuSelected,
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
            onMenuSelected: onMenuSelected,
          ),
      ],
    );
  }
}

class ItemRow<E extends TableElement<E, C, M>, C, M> extends StatelessWidget {
  final List<TableColumn<C>> columns;
  final E row;
  final int index;
  final Function(E) onSelected;
  final Function(E, M)? onMenuSelected;

  const ItemRow({
    required this.columns,
    required this.row,
    required this.index,
    required this.onSelected,
    required this.onMenuSelected,
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
        focusColor: Palette.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final TableColumn<C> column in columns)
              TableCell(
                content: row.cell(
                  column: column,
                  onMenuSelected: onMenuSelected,
                ),
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
      // Uncomment to show column separators
      /*decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Palette.borderInputEnabled, width: 1),
        ),
      ),*/
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FooterTotal(total),
          const Spacer(),
          const FooterControls(),
          const Spacer(),
          const PageSizeSelector(),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: 'Total',
              color: Palette.textTitle,
              size: 14,
              weight: FontWeight.normal,
            ),
            const HBox(8),
            CustomText(
              text: '$total',
              color: Palette.textTitle,
              size: 14,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class FooterControls extends StatelessWidget {
  const FooterControls();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SecondaryIconButton(
          size: 34,
          iconSize: 22,
          icon: Icons.first_page,
          onPressed: () {},
        ),
        const HBox(8),
        SecondaryIconButton(
          size: 34,
          iconSize: 22,
          icon: Icons.keyboard_arrow_left_rounded,
          onPressed: () {},
        ),
        const HBox(8),
        const CustomCard(
          width: 60,
          borderSize: 1,
          cornerRadius: 4,
          borderColor: Palette.borderButtonSecondary,
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Center(
            child: CustomText(
              text: '1 / 10',
              color: Palette.textTitle,
              size: 14,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const HBox(8),
        SecondaryIconButton(
          size: 34,
          iconSize: 22,
          icon: Icons.keyboard_arrow_right_rounded,
          onPressed: () {},
        ),
        const HBox(8),
        SecondaryIconButton(
          size: 34,
          iconSize: 22,
          icon: Icons.last_page,
          onPressed: () {},
        ),
        const HBox(8),
      ],
    );
  }
}

class PageSizeSelector extends StatefulWidget {
  const PageSizeSelector();

  @override
  State<PageSizeSelector> createState() => _PageSizeSelectorState();
}

class _PageSizeSelectorState extends State<PageSizeSelector> {
  final CustomDropdownSingleController<String> controller =
      CustomDropdownSingleController();

  @override
  void initState() {
    super.initState();
    controller.select('10');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomText(
            text: 'Page size',
            color: Palette.textTitle,
            size: 14,
            weight: FontWeight.normal,
          ),
          const HBox(8),
          CustomDropdownSingle<String>(
            width: 90,
            values: DropdownItem.fromList(['10', '20', '50', '100']),
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class TableColumn<C> {
  final C id;
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

abstract class TableElement<E, C, M> {
  Widget cell({
    required TableColumn<C> column,
    required Function(E, M)? onMenuSelected,
  });
}
