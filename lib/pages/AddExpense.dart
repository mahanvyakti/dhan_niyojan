import 'package:dhan_niyojan/models/Expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key, this.expense}) : super(key: key);
  final Expense? expense;
  @override
  AddwExpenseStatePage createState() => AddwExpenseStatePage();
}

class AddwExpenseStatePage extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  // TextEditingController _locationController = TextEditingController();
  // TextEditingController _notesController = TextEditingController();

  List<String> paymentModes = ["UPI", "Debit Card", "Cash", "Other"];
  List<String> categories = [
    "Food",
    "Groceries",
    "Travel",
    "Investment",
    "Bills",
    "Entertainment",
    "Shopping",
    "Gift",
    "Donation",
    "Other",
    "Medicines"
  ];
  List<String> accounts = [
    "Cash",
    "Cash (Daddy)",
    "SBI",
    "Union Bank",
    "IPPB",
    "Federal Bank"
  ];

  String expenseMode = "UPI";
  String expenseAccount = "SBI";
  String expenseCategory = "Food";

  @override
  void initState() {
    super.initState();
  }

  inputPaddingWrapper(Widget inuptField) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: inuptField,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "${widget.expense == null ? 'Add New' : 'Edit Existing'} Expense",
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NeuCard(
            cardHeight: MediaQuery.of(context).size.height * 0.85,
            cardColor: const Color.fromARGB(255, 241, 120, 159),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.expense == null ? 'Add' : 'Update'} Expense Details",
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Title'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a title';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _amountController,
                                decoration:
                                    const InputDecoration(labelText: 'Amount'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an amount';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _dateController,
                                decoration:
                                    const InputDecoration(labelText: 'Date'),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      _dateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a date';
                                  }
                                  if (value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                              ),

                              // Add more text form fields for other expense attributes
                              inputPaddingWrapper(
                                DropdownButtonFormField(
                                  isDense: false,
                                  value: expenseMode,
                                  // decoration: const InputDecoration(
                                  //   labelText: 'Mode',
                                  //   border: OutlineInputBorder(),
                                  // ),
                                  hint: const Text("Mode"),
                                  items: paymentModes.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: NeuCard(
                                        cardColor: Colors.amber[200],
                                        child: Center(
                                          child: Text(value),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      expenseMode = value!;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Save the expense
                                    // You can call a function to save the expense to the database here
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
