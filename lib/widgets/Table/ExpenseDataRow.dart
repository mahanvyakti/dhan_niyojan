import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:dhan_niyojan/models/Expense.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
/// An object to set the expense collection data source to the datagrid. This
/// is used to map the expense data to the datagrid widget.
class ExpenseDataSource extends DataGridSource {
  /// Creates the Expense data source class with required details.
  ExpenseDataSource({required List<Expense> expenseData}) {
    _expenseData = expenseData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'id', value: e.id.toString()),
              DataGridCell<String>(
                  columnName: 'DateTime', value: DateFormat('MMM dd, yy hh:mm').format(e.date)),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<double>(columnName: 'amount', value: e.amount.truncateToDouble()),

              DataGridCell<String>(columnName: 'mode', value: e.mode),
              DataGridCell<String>(columnName: 'account', value: e.account),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(columnName: 'isPlanned', value: e.isPlanned ? "Yes" : "No"),
              DataGridCell<String>(columnName: 'isEssential', value: e.isEssential ? "Yes" : "No"),
              DataGridCell<String>(columnName: 'isSettled', value: e.isSettled ? "Yes" : "No"),
              DataGridCell<String>(columnName: 'location', value: e.location),
              DataGridCell<String>(columnName: 'description', value: e.notes),
            ]))
        .toList();
  }

  List<DataGridRow> _expenseData = [];

  @override
  List<DataGridRow> get rows => _expenseData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child:NeuCard(
        cardColor: Colors.amber,
        child: Text(e.value.toString(), textAlign: TextAlign.center,  style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),)),
      ),);
    }).toList());
  }
}