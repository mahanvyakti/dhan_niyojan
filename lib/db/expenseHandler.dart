import 'package:dhan_niyojan/models/Expense.dart';
import 'package:dhan_niyojan/db/dbHandler.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseHandler{
  static Future<List<Expense>> getExpenses() async {
    var dbClient = await DBHandler().database;
    List<Map> maps = await dbClient.query(Expense.tableName);
    return List.generate(maps.length, (index) => Expense.fromJson(maps[index]));
  }

  static Future<void> insertExpense(Expense expense) async {
    var db = await DBHandler().database;
    await db.insert(
      Expense.tableName,
      expense.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateExpense(Expense expense) async {
    var db = await DBHandler().database;

    await db.update(
      Expense.tableName,
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  static Future<void> deleteExpense(Expense expense) async {
    var db = await DBHandler().database;
    await db.delete(Expense.tableName, where: 'id = ?', whereArgs: [expense.id]);
  }

  static Future<void> deleteAllExpenses() async {
    var db = await DBHandler().database;
    await db.delete(Expense.tableName);
  }

  static Future<List<Expense>> expenseSuggestion(String titleQuery) async {
    var db = await DBHandler().database;
    List<Map> result;
    List<Expense> expenseSuggestions = [];
    result = await db
        .rawQuery("SELECT * FROM ${Expense.tableName} WHERE title LIKE '%$titleQuery%'");

    //Get minimum of result.length and 3
    int limit = result.length < 3 ? result.length : 3;
    for (int i = 0; i < limit; i++) {
      Expense expense = Expense.fromJson(result[i]);
      expenseSuggestions.add(expense);
    }
    return expenseSuggestions;
  }
}