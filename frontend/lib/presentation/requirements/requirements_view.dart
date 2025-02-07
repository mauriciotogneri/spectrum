import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/state/requirements/requirements_state.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/utils/palette.dart';

class RequirementsView extends StatelessWidget {
  final RequirementsState state;

  const RequirementsView._(this.state);

  factory RequirementsView.instance() =>
      RequirementsView._(RequirementsState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementsState>(
      state: state,
      builder: (state, context) => Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const VBox(16),
            TableFilters(this.state),
            const VBox(16),
            const Table(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return const Title4(text: 'Requirements');
  }
}

class TableFilters extends StatelessWidget {
  final RequirementsState state;

  const TableFilters(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextInputField(
          width: 250,
          hint: 'Filter',
          controller: state.filterController,
        ),
        DropdownInput<String>(
          width: 200,
          values: Data.currentProject.components,
          controller: state.componentController,
          focusNode: state.componentFocusNode,
          allowDeselection: true,
          hint: 'Component',
        ),
        DropdownInput<String>(
          width: 200,
          values: Data.currentProject.platforms,
          controller: state.platformController,
          focusNode: state.platformFocusNode,
          allowDeselection: true,
          hint: 'Platform',
        ),
      ],
    );
  }
}

class Table extends StatelessWidget {
  const Table();

  @override
  Widget build(BuildContext context) {
    const invoices = [
      [
        'INV001',
        'Paid',
        'Credit Card',
        r'$250.00',
      ],
      [
        'INV002',
        'Pending',
        'PayPal',
        r'$150.00',
      ],
      [
        'INV003',
        'Unpaid',
        'Bank Transfer',
        r'$350.00',
      ],
      [
        'INV004',
        'Paid',
        'Credit Card',
        r'$450.00',
      ],
      [
        'INV005',
        'Paid',
        'PayPal',
        r'$550.00',
      ],
      [
        'INV006',
        'Pending',
        'Bank Transfer',
        r'$200.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
      [
        'INV007',
        'Unpaid',
        'Credit Card',
        r'$300.00',
      ],
    ];

    final headings = [
      'Invoice',
      'Status',
      'Method',
      'Amount',
    ];

    return Expanded(
      child: ShadTable(
        columnCount: invoices[0].length,
        rowCount: invoices.length,
        header: (context, column) => ShadTableCell.header(
          child: Text(headings[column]),
        ),
        columnSpanExtent: (index) => const FractionalSpanExtent(0.25),
        onRowTap: (index) => print(invoices[index]),
        rowSpanBackgroundDecoration: (row) => row == 0
            ? const SpanDecoration(
                color: Palette.backgroundTableHeader,
              )
            : null,
        builder: (context, index) {
          final List<String> invoice = invoices[index.row];
          return ShadTableCell(
            alignment: Alignment.centerLeft,
            child: Text(
              invoice[index.column],
              style: index.column == 0
                  ? const TextStyle(fontWeight: FontWeight.w500)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
