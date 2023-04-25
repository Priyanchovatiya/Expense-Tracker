class IncomeExpenseModel {
  String title;
  double amount;
  String category;
  String mode;
  String date;
  String time;

  IncomeExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.mode,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'amount': amount,
      'category': category,
      'mode': mode,
      'date': date,
      'time': time,
    };
  }
}
