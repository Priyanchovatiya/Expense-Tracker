import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalysisChart extends StatelessWidget {
  const AnalysisChart(
      {super.key,
      required this.dataMap,
      required this.centertext,
      required this.total});

  final Map<String, double> dataMap;
  final String centertext;
  final double total;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 1500),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width /
          2.7, //determines the size of the chart
      centerText: centertext,
      chartType: ChartType.ring, //can be changed to ChartType.ring
      ringStrokeWidth: 40,
      legendOptions: const LegendOptions(
          showLegendsInRow: true, legendPosition: LegendPosition.bottom),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValuesInPercentage: true,
      ),
    );
  }
}
