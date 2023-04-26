import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late var income;
  late var expense;

  final userEmail = FirebaseAuth.instance.currentUser!.email;

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
  }

  @override
  void initState() {
    super.initState();
    getIncomeExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFCDF2E5).withOpacity(0.5),
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(35.0),
            ),

          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                height: 100,
               width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),

              ),
              Container(
                margin: EdgeInsets.all(20.0),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),

              )
            ],
          )
        ],

      ),
    );
  }
}
