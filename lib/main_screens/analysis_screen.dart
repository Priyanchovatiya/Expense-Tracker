import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/customs/custom_text.dart';
import 'package:expensetracker/customs/graph.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  Map<String, double> categoryWiseIncomeList = {"income": 0};
  Map<String, double> categoryWiseExpenseList = {"expense": 0};

  double income = 0;
  double expense = 0;

  Future<void> getIncomeExpense() async {
    final CollectionReference incomeCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("income-list");

    final CollectionReference expenseCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("expense-list");

    double totalIncome = 0;
    double totalExpense = 0;

    final QuerySnapshot incomeSnapshot = await incomeCollectionRef.get();
    final List<QueryDocumentSnapshot> incomeDocs = incomeSnapshot.docs;

    incomeDocs.forEach((doc) {
      totalIncome += doc.get("amount") as double;
    });

    final QuerySnapshot expenseSnapshot = await expenseCollectionRef.get();
    final List<QueryDocumentSnapshot> expenseDocs = expenseSnapshot.docs;

    expenseDocs.forEach((doc) {
      totalExpense += doc.get("amount") as double;
    });

    setState(() {
      income = totalIncome;
      expense = totalExpense;
    });
    print(income);
    print(expense);
  }

  Future<void> getCategoryWiseTotal() async {
    final CollectionReference incomeCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("income-list");

    final CollectionReference expenseCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("expense-list");

    //For getting category wise income
    final Map<String, double> categoryWiseIncomeTotal = {};
    final QuerySnapshot incomeSnap = await incomeCollectionRef.get();
    final List<QueryDocumentSnapshot> incomeDocs = incomeSnap.docs;
    incomeDocs.forEach((doc) {
      final String category = doc.get("category") as String;
      final double amount = doc.get("amount") as double;
      if (categoryWiseIncomeTotal.containsKey(category)) {
        categoryWiseIncomeTotal[category] =
            (categoryWiseIncomeTotal[category] ?? 0) + amount;
      } else {
        categoryWiseIncomeTotal[category] = amount;
      }
    });

    //For Getting Category wise Expense
    final Map<String, double> categoryWiseExpenseTotal = {};
    final QuerySnapshot expenseSnap = await expenseCollectionRef.get();
    final List<QueryDocumentSnapshot> expenseDocs = expenseSnap.docs;
    expenseDocs.forEach((doc) {
      final String category = doc.get("category") as String;
      final double amount = doc.get("amount") as double;
      if (categoryWiseExpenseTotal.containsKey(category)) {
        categoryWiseExpenseTotal[category] =
            (categoryWiseExpenseTotal[category] ?? 0) + amount;
      } else {
        categoryWiseExpenseTotal[category] = amount;
      }
    });

    setState(() {
      categoryWiseIncomeList = categoryWiseIncomeTotal;
      categoryWiseExpenseList = categoryWiseExpenseTotal;
    });
    print(categoryWiseIncomeList);
    print(categoryWiseExpenseList);
  }

  @override
  void initState() {
    super.initState();
    getCategoryWiseTotal();
    getIncomeExpense();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomText(
              fontWeight: FontWeight.bold,
              text: "Analysis",
              size: 28,
              colour: Colors.black),
          const SizedBox(
            height: 20,
          ),
          const CustomText(
              fontWeight: FontWeight.bold,
              text: "Income",
              size: 24,
              colour: Colors.black),
          const SizedBox(
            height: 20,
          ),
          AnalysisChart(
            centertext: "Income",
            dataMap: categoryWiseIncomeList,
            total: income,
          ),
          const SizedBox(
            height: 50,
          ),
          const CustomText(
              fontWeight: FontWeight.bold,
              text: "Expense",
              size: 24,
              colour: Colors.black),
          const SizedBox(
            height: 20,
          ),
          AnalysisChart(
            centertext: "Expense",
            dataMap: categoryWiseExpenseList,
            total: expense,
          ),
        ],
      ),
    );
  }
}
