import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:expensetracker/Forms/expense.dart';
import 'package:expensetracker/Forms/income.dart';
import 'package:expensetracker/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: purple,
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  radius: const Radius.circular(12),
                  backgroundColor: Colors.white,
                  indicatorColor: navBackColor,
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,
                  height: 35,
                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: const [
                    SegmentTab(
                      label: 'INCOME',
                      // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                    ),
                    SegmentTab(
                      label: 'EXPENSE',
                    ),
                    const SegmentTab(label: 'TRANSFER'),
                  ],
                ),
              ),
              // Sample pages
              Container(
                padding: const EdgeInsets.only(top: 70),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    IncomeForm(),
                    ExpenseForm(),
                    SampleWidget(
                      label: 'THIRD PAGE',
                      color: Colors.orange.shade200,
                    ),
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

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: Text(label),
    );
  }
}
