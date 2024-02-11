import 'package:dhan_niyojan/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:dhan_niyojan/widgets/Table/ExpenseDataRow.dart';
import 'package:dhan_niyojan/models/Expense.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTable extends StatefulWidget {
  const ExpenseTable({
    super.key,
  });

  @override
  State<ExpenseTable> createState() => _ExpenseTableState();
}

class _ExpenseTableState extends State<ExpenseTable> {
  late ExpenseDataSource expenseDataSource;
  List<Expense> expenses = <Expense>[];
  final DataGridController _dgController = DataGridController();

  @override
  void initState() {
    super.initState();
    expenses = getExpenseData();
    expenseDataSource = ExpenseDataSource(expenseData: expenses);
  }

  List<Expense> getExpenseData() {
    return [
      Expense(
          account: "SBI",
          amount: 100,
          category: "Food",
          created_at: DateTime(2024, 02, 10, 12, 15, 16),
          date: DateTime(2024, 02, 02, 18, 18, 01),
          id: 1,
          isEssential: true,
          isPlanned: false,
          isSettled: true,
          location: "Pune",
          mode: "UPI",
          title: "Kothimbir Vadi",
          notes: "Paav Kilo",
          transaction_amount: 100,
          modified_at: DateTime(2024, 02, 15, 36, 15, 16)),
      Expense(
          account: "SBI",
          amount: 100,
          category: "Food",
          created_at: DateTime(2024, 02, 10, 12, 15, 16),
          date: DateTime(2024, 02, 09, 00, 55, 46),
          id: 2,
          isEssential: true,
          isPlanned: false,
          isSettled: true,
          location: "Pune",
          mode: "UPI",
          title: "Kothimbir Vadi",
          notes: "Paav Kilo",
          transaction_amount: 100,
          modified_at: DateTime(2024, 02, 10, 12, 15, 16)),
      Expense(
          account: "SBI",
          amount: 100,
          category: "Food",
          created_at: DateTime(2024, 02, 10, 12, 15, 16),
          date: DateTime(2024, 02, 10, 10, 55, 46),
          id: 3,
          isEssential: true,
          isPlanned: false,
          isSettled: true,
          location: "Pune",
          mode: "UPI",
          title: "Kothimbir Vadi",
          notes: "Paav Kilo",
          transaction_amount: 100,
          modified_at: DateTime(2024, 02, 10, 12, 15, 16)),
    ];
  }

  List<GridColumn> getExpenseColumns() {
    List<GridColumn> columns = [];
    var index = 0.0;

    ExpensesColumnNameToTitleMap.forEach((key, value) {
      columns.add(GridColumn(
        columnName: key,
        label: Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: NeuTextButton(
            onPressed: () async => await _dgController.scrollToColumn(index),
            enableAnimation: true,
            text: Text(value,
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ));
      index++;
    });

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      controller: _dgController,
      allowSorting: true,
      allowFiltering: true,
      source: expenseDataSource,
      columnWidthMode: ColumnWidthMode.lastColumnFill,
      columns: getExpenseColumns(),
    );
  }
}
