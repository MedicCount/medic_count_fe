import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Define a class to hold the counts data
class medicineAnalysis {
  final String group;
  final double counts;

  medicineAnalysis(this.group, this.counts);
}

class BaseLineChart extends StatefulWidget {
  const BaseLineChart({Key? key}) : super(key: key);

  @override
  State<BaseLineChart> createState() => _BaseLineChartState();
}

class _BaseLineChartState extends State<BaseLineChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SfCartesianChart(
          legend: const Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: const CategoryAxis(),
          primaryYAxis: const NumericAxis(
            title: AxisTitle(text: 'medicine#'),
            interval: 20,
            majorGridLines: MajorGridLines(
                width: 0), // Optionally, you can remove grid lines
          ),
          series: <LineSeries<medicineAnalysis, String>>[
            LineSeries<medicineAnalysis, String>(
              isVisibleInLegend: false,
              dataSource: <medicineAnalysis>[
                medicineAnalysis('G1', 35),
                medicineAnalysis('G2', 28),
                medicineAnalysis('G3', 34),
                medicineAnalysis('G4', 32),
                medicineAnalysis('G5', 40),
              ],
              xValueMapper: (medicineAnalysis counts, _) => counts.group,
              yValueMapper: (medicineAnalysis counts, _) => counts.counts,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}
