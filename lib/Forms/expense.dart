import 'package:expensetracker/Models/income.dart';
import 'package:expensetracker/controller/transaction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'package:expensetracker/constant.dart';
import 'package:expensetracker/customs/custom_field_income.dart';
import 'package:expensetracker/customs/custom_text.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController category = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController timecontroller =
      TextEditingController(text: TimeOfDay.now().toString().substring(10, 15));
  final TextEditingController mode = TextEditingController();

  String dropCategory = expenseCategory[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category.text = expenseCategory[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Form(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTransactionField(
              textEditingController: title,
              obsecure: false,
              label: "Title",
              hint: 'Enter Title',
              icon: Icons.title,
              onTap: () {},
              validator: (p0) {},
            ),
            CustomTransactionField(
              textEditingController: amount,
              obsecure: false,
              label: "Amount",
              hint: 'Enter Amount',
              icon: Icons.money,
              onTap: () {},
              validator: (p0) {},
            ),
            const CustomText(
                fontWeight: FontWeight.w500,
                text: "Category",
                size: 18,
                colour: Colors.black),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: DropdownButton(
                  isExpanded: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  underline: Container(),
                  elevation: 0,
                  value: dropCategory,
                  hint: const Text("Select Category"),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black.withOpacity(0.9),
                  ),

                  // Array list of items
                  items: expenseCategory.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropCategory = newValue!;
                      category.text = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomTransactionField(
              textEditingController: mode,
              obsecure: false,
              label: "Payment Mode",
              hint: 'Enter Payment Method',
              icon: Icons.device_unknown,
              onTap: () {},
              validator: (p0) {},
            ),
            CustomTransactionField(
              textEditingController: dateController,
              obsecure: false,
              label: "Date",
              hint: 'Select Date',
              icon: Icons.date_range,
              onTap: (() async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050));

                if (pickedDate != null) {
                  dateController.text =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                }
              }),
              validator: (p0) {},
            ),
            CustomTransactionField(
              textEditingController: timecontroller,
              obsecure: false,
              label: "Time",
              hint: 'Select Time',
              icon: Icons.calendar_today,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    timecontroller.text =
                        formattedTime; //set the value of text field.
                  });
                } else {}
              },
              validator: (p0) {},
            ),
            GestureDetector(
              onTap: () {
                IncomeExpenseModel incomeExpenseModel = IncomeExpenseModel(
                    title: title.text,
                    amount: double.parse(amount.text),
                    category: category.text,
                    mode: mode.text,
                    date: dateController.text,
                    time: timecontroller.text);
                FirebaseTranscation().addExpense(incomeExpenseModel);
              },
              child: Container(
                height: 50,
                decoration:  BoxDecoration(
                    color: korangeColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(
                  child: Text(
                    "Add Expense",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
