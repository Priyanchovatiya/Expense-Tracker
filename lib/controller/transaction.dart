import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/Models/income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseTranscation {
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  Future<void> addIncome(IncomeExpenseModel incomeExpenseModel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("income-list")
        .doc()
        .set(incomeExpenseModel.toMap())
        .then((value) =>
            Fluttertoast.showToast(msg: "Income Added Successfully"));
  }

  Future<void> addExpense(IncomeExpenseModel incomeExpenseModel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("expense-list")
        .doc()
        .set(incomeExpenseModel.toMap())
        .then((value) =>
            Fluttertoast.showToast(msg: "Expense Added Successfully"));
  }
}
