import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';

import '../customs/custom_cue_card.dart';
import '../customs/custom_text.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  double income = 0;
  double expense = 0;
  double cur_month_income = 0;
  double cur_month_expense = 0;
  double total_balance = 0;
  double cur_month_balance = 0;
  int month_limit = 0;

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

    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    final DocumentSnapshot userDoc = await userDocRef.get();
    setState(() {
      month_limit = userDoc.get("month-limit") as int;
    });

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
      total_balance = totalIncome - totalExpense;
    });

    print("Totla balance is $total_balance");
    print("Totla income balance is $income");
    print("Totla expense balance is $expense");
  }

  Future<void> getCurrentMonthIncomeExpense() async {
    final CollectionReference incomeCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("income-list");

    final CollectionReference expenseCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("expense-list");

    double currentMonthIncome = 0;
    double currentMonthExpense = 0;

    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    final QuerySnapshot incomeSnapshot = await incomeCollectionRef
        .where('date',
            isGreaterThanOrEqualTo:
                DateFormat('dd-MM-yyyy').format(firstDayOfMonth),
            isLessThanOrEqualTo:
                DateFormat('dd-MM-yyyy').format(lastDayOfMonth))
        .get();
    final List<QueryDocumentSnapshot> incomeDocs = incomeSnapshot.docs;

    incomeDocs.forEach((doc) {
      String dateString = doc.get('date');
      DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);

      if (date.month == now.month) {
        currentMonthIncome += doc.get("amount") as double;
      }
    });

    final QuerySnapshot expenseSnapshot = await expenseCollectionRef
        .where('date',
            isGreaterThanOrEqualTo:
                DateFormat('dd-MM-yyyy').format(firstDayOfMonth),
            isLessThanOrEqualTo:
                DateFormat('dd-MM-yyyy').format(lastDayOfMonth))
        .get();
    final List<QueryDocumentSnapshot> expenseDocs = expenseSnapshot.docs;

    expenseDocs.forEach((doc) {
      String dateString = doc.get('date');
      DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);

      if (date.month == now.month) {
        currentMonthExpense += doc.get("amount") as double;
      }
    });

    setState(() {
      cur_month_income = currentMonthIncome;
      cur_month_expense = currentMonthExpense;
      cur_month_balance = cur_month_income - cur_month_expense;
    });
    print(cur_month_balance);
    print(cur_month_income);
    print(cur_month_expense);
  }

  @override
  void initState() {
    super.initState();
    getIncomeExpense();
    getCurrentMonthIncomeExpense();
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
                text: "Total Overview",
                fontWeight: FontWeight.w800,
                size: 22.0,
                colour: Color(0xFF111111),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 175,
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: cueCard(
                          colour: Colors.green,
                          icon: CupertinoIcons.arrow_down,
                          headText: "Income",
                          data: income.toString(),
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
                          data: expense.toString(),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            fontWeight: FontWeight.w500,
                            text: "Total Balance",
                            size: 18,
                            colour: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            fontWeight: FontWeight.w500,
                            text: total_balance.toString(),
                            size: 18,
                            colour: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 50,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.3),
              //         offset: const Offset(
              //           2.0,
              //           2.0,
              //         ),
              //         blurRadius: 4.0,
              //         spreadRadius: 1.0,
              //       ), //BoxShadow
              //       //BoxShadow
              //     ],
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              //   child: Center(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         CustomText(
              //             fontWeight: FontWeight.w500,
              //             text: "Total Balance",
              //             size: 18,
              //             colour: Colors.black),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         CustomText(
              //             fontWeight: FontWeight.w500,
              //             text: total_balance.toString(),
              //             size: 18,
              //             colour: Colors.black),
              //       ],
              //     ),
              //   ),
              // ),
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
                  color: Colors.black.withOpacity(0.8),
                  // gradient: const LinearGradient(
                  //   colors: [Color(0xFFFD203B), Color(0xFFFD5872)],
                  //   begin: Alignment.bottomCenter,
                  //   end: Alignment.topCenter,
                  // ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 15.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          fontWeight: FontWeight.bold,
                          text:
                              ("Used: ${100 - ((month_limit - expense) / 100)}%"),
                          size: 25.0,
                          colour: Colors.white),
                      const SizedBox(
                        height: 20.0,
                      ),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 70,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        percent: 0.5,
                        //percent: (10 - ((month_limit - expense) / 1000)) / 10,
                        center:
                            Text("${100 - ((month_limit - expense) / 100)}%"),
                        progressColor: Colors.redAccent,
                        barRadius: Radius.circular(20),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          CustomText(
                              fontWeight: FontWeight.w500,
                              text: 'Moth Limit : ',
                              size: 18.0,
                              colour: Colors.white),
                          CustomText(
                              fontWeight: FontWeight.bold,
                              text: month_limit.toString(),
                              size: 25.0,
                              colour: Colors.white),
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
                      data: cur_month_income.toString(),
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
                      data: cur_month_expense.toString(),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          fontWeight: FontWeight.w500,
                          text: "Month Balance",
                          size: 18,
                          colour: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                          fontWeight: FontWeight.w500,
                          text: cur_month_balance.toString(),
                          size: 18,
                          colour: Colors.black),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
