import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../customs/custom_cue_card.dart';
import '../customs/custom_text.dart';

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
    return Scaffold(
      backgroundColor: greyBGColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: greyBGColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const CustomText(
                text: "Overview",
                fontWeight: FontWeight.w900,
                size: 30.0,
                colour: Color(0xFF111111),
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                text: "Monthly Limit Card",
                fontWeight: FontWeight.w800,
                size: 22.0,
                colour: Color(0xFF111111),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(

                    colors: [Color(0xFFFD203B), Color(0xFFFD5872)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:15.0 , right: 15.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      CustomText(fontWeight: FontWeight.bold, text: '90%', size: 25.0, colour: Colors.white),

                      const SizedBox( height: 20.0,),
                      const Divider(

                        color: Colors.white,
                        thickness: 10,

                      ),
                      const SizedBox( height: 20.0,),
                      Row(
                        children:  const [
                           CustomText(fontWeight: FontWeight.w500, text: 'Total Used Money : ', size: 18.0, colour: Colors.white),
                           CustomText(fontWeight: FontWeight.bold, text: '10000', size: 25.0, colour: Colors.white),
                        ],
                      )

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const CustomText(
                text: "This Month",
                fontWeight: FontWeight.w800,
                size: 22.0,
                colour: Color(0xFF111111),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 125,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    //BoxShadow
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: cueCard(
                          colour: Colors.green,
                          icon: CupertinoIcons.arrow_down,
                          headText: "Income",
                          // data: income.toString(),
                        )),
                    Container(
                      height: 105,
                      width: 2.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF111111).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Expanded(
                        child: cueCard(
                          colour: Colors.red,
                          icon: CupertinoIcons.arrow_up,
                          headText: "Expenses",
                          // data: expense.toString(),
                        )),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
