import 'package:cloud_firestore/cloud_firestore.dart';
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
    setState(() {
      
    });

   mergedList.sort((a, b) {
  DateTime aTime = DateFormat('dd-MM-yyyy hh:mm').parse('${a['date']} ${a['time']}');
  DateTime bTime = DateFormat('dd-MM-yyyy hh:mm').parse('${b['date']} ${b['time']}');
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
    return mergedList.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: mergedList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> transaction = mergedList[index];
              final bool isIncome = transaction['type'] == 'income';
              return Container(
                color: isIncome ? Colors.green : Colors.red,
                child: ListTile(
                  title: Text(transaction['title']),
                  subtitle: Text(transaction['category']),
                  trailing: Text('\$${transaction['amount']}'),
                ),
              );
            },
          );
  }
}
