import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/customs/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> mergedList = [];
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  Future<void> getHistory() async {
    final CollectionReference incomeCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("income-list");

    final CollectionReference expenseCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection("expense-list");

    List<DocumentSnapshot> incomeDocs = [];
    QuerySnapshot incomeSnap = await incomeCollectionRef.get();
    if (incomeSnap.docs.isNotEmpty) {
      incomeDocs = incomeSnap.docs;
    }

    List<DocumentSnapshot> expenseDocs = [];
    QuerySnapshot expenseSnap = await expenseCollectionRef.get();
    if (expenseSnap.docs.isNotEmpty) {
      expenseDocs = expenseSnap.docs;
    }

    mergedList = [];
    incomeDocs.forEach((doc) {
      mergedList.add({
        "date": doc.get("date"),
        "time": doc.get("time"),
        "title": doc.get("title"),
        "category": doc.get("category"),
        "type": "income",
        "amount": doc.get("amount")
      });
    });
    expenseDocs.forEach((doc) {
      mergedList.add({
        "date": doc.get("date"),
        "time": doc.get("time"),
        "title": doc.get("title"),
        "category": doc.get("category"),
        "type": "expense",
        "amount": doc.get("amount")
      });
    });
    setState(() {});

    mergedList.sort((a, b) {
      DateTime aTime =
          DateFormat('dd-MM-yyyy hh:mm').parse('${a['date']} ${a['time']}');
      DateTime bTime =
          DateFormat('dd-MM-yyyy hh:mm').parse('${b['date']} ${b['time']}');
      return bTime.compareTo(aTime);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: const CustomText(
              text: "History",
              fontWeight: FontWeight.w500,
              size: 30.0,
              colour: Color(0xFF111111),
            ),
          ),
          mergedList.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: MediaQuery.of(context).size.height - 80,
                  child: ListView.builder(
                    itemCount: mergedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> transaction =
                          mergedList[index];
                      final bool isIncome = transaction['type'] == 'income';
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(blurRadius: 5, offset: Offset(2, 0))
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          title: Text(
                            transaction['category'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              transaction['date'].toString() +
                                  " " +
                                  transaction['time'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          trailing: CustomText(
                            text: '\$${transaction['amount']}',
                            fontWeight: FontWeight.w700,
                            size: 18.0,
                            colour: isIncome
                                ? Colors.green.withOpacity(0.9)
                                : Colors.redAccent.withOpacity(0.9),
                          ),
                          // trailing: isIncome ? Text('\$${transaction['amount']}') : Text('\$${transaction['amount']}'
                        ),
                      );
                    },
                  ),
                ),

        ],
      ),
    );

  }
}
