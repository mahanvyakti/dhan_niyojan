// ignore_for_file: non_constant_identifier_names

class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.mode,
    required this.account,
    required this.category,
    required this.isPlanned,
    required this.isEssential,
    required this.isSettled,
    required this.transaction_amount,
    required this.location,
    required this.notes,
    required this.created_at,
    required this.modified_at,
  });
  static const String tableName = "expenses";

  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final String mode;
  final String account;
  final String category;
  final bool isPlanned;
  final bool isEssential;
  final bool isSettled;
  final double transaction_amount;
  final String location;
  final String notes;
  final DateTime created_at;
  final DateTime modified_at;

  Expense copyWith({
    required int id,
    required String title,
    required double amount,
    required DateTime date,
    required String mode,
    required String account,
    required String category,
    required bool isPlanned,
    required bool isEssential,
    required bool isSettled,
    required double transaction_amount,
    required String location,
    required String notes,
    required DateTime created_at,
    required DateTime modified_at,
  }) =>
      Expense(
        id: id,
        title: title,
        amount: amount,
        date: date,
        mode: mode,
        account: account,
        category: category,
        isPlanned: isPlanned,
        isEssential: isEssential,
        isSettled: isSettled,
        transaction_amount: transaction_amount,
        location: location,
        notes: notes,
        created_at: created_at,
        modified_at: modified_at,
      );

  factory Expense.fromJson(Map<dynamic, dynamic> json) => Expense(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      date: DateTime.parse(json["date"]),
      mode: json["mode"],
      account: json["account"],
      category: json["category"],
      isPlanned:
          json["isPlanned"] == 1, //Database stores 1 for true and 0 for false
      isEssential: json["isEssential"] == 1,
      isSettled: json["isSettled"] == 1,
      transaction_amount: json["transaction_amount"],
      location: json["location"],
      notes: json["notes"],
      created_at: DateTime.parse(json["created_at"]),
      modified_at: DateTime.parse(json["modified_at"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date.toString(),
        "mode": mode,
        "account": account,
        "category": category,
        "isPlanned": isPlanned,
        "isEssential": isEssential,
        "isSettled": isSettled,
        "transaction_amount": transaction_amount,
        "location": location,
        "notes": notes,
        "created_at": created_at.toString(),
        "modified_at": modified_at.toString(),
      };
}
