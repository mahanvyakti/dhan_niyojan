import 'package:dhan_niyojan/db/expenseHandler.dart';
import 'package:dhan_niyojan/models/Expense.dart';
import 'package:dhan_niyojan/widgets/MessageBox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhan_niyojan/widgets/Table/ExpenseTable.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:dhan_niyojan/pages/AddExpense.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Expense>> getExpenses() async {
    List<Expense> expensesList = await ExpenseHandler.getExpenses();
    return expensesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green[200],
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
          child: FutureBuilder<List<Expense>>(
            future: ExpenseHandler.getExpenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return MessageBox(
                  boxColor: Colors.amber[100],
                  childWidget: const CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return MessageBox(
                  boxColor: Colors.red[100],
                  childWidget: Text(
                    "Something went wrong while getting expenses...",
                    style: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return MessageBox(
                  boxColor: Colors.indigo[100],
                  childWidget: Text(
                    "No expesnes added yet...\nTap on Add Button to create one!",
                    style: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return NeuCard(
                cardHeight: MediaQuery.of(context).size.height * 0.85,
                cardColor: const Color.fromARGB(255, 241, 120, 159),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: const ExpenseTable(),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: NeuTextButton(
        borderRadius: BorderRadius.circular(12),
        buttonColor: const Color.fromARGB(255, 236, 199, 211),
        enableAnimation: true,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddExpensePage())),
        animationDuration: 5,
        text: const Text(
          "Add",
        ),
      ),
    );
  }
}
