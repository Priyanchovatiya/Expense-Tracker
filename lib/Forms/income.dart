import 'package:expensetracker/constant.dart';
import 'package:expensetracker/customs/custom_field_income.dart';
import 'package:expensetracker/customs/custom_text.dart';
import 'package:expensetracker/customs/custome_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({super.key});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController category = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController timecontroller =
      TextEditingController(text: TimeOfDay.now().toString().substring(10, 15));
  final TextEditingController mode = TextEditingController();

  bool showInputField = false;
  String dropDoctor = incomeCategory[0];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              textEditingController: title,
              obsecure: false,
              label: "Amount",
              hint: 'Enter Amount',
              icon: Icons.money,
              onTap: () {},
              validator: (p0) {},
            ),
            CustomText(
                fontWeight: FontWeight.w500,
                text: "Category",
                size: 18,
                colour: Colors.black),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF1F4F8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: DropdownButton(
                  isExpanded: true,
                  // alignment: AlignmentDirectional.bottomEnd,

                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  underline: Container(),
                  elevation: 0,
                  // Initial Value
                  value: dropDoctor,
                  hint: Text("Select Category"),
                  // Down Arrow Icon
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black.withOpacity(0.9),
                  ),

                  // Array list of items
                  items: incomeCategory.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDoctor = newValue!;
                      category.text = newValue;
                      if (category.text ==
                          incomeCategory[incomeCategory.length - 1]) {
                        showInputField = true;
                      } else {
                        showInputField = false;
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            if (showInputField)
              Column(
                children: [
                  CustomTransactionField(
                    obsecure: false,
                    hint: "Enter Category",
                    label: "Category",
                    textEditingController: category,
                    icon: Icons.category_outlined,
                    onTap: () {},
                    validator: (String? msg) {
                      if (msg!.isEmpty) {
                        return "This is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
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
            Positioned(
              bottom: 100,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.save),
              ),
            )
          ],
        ),
      )),
    );
  }
}
