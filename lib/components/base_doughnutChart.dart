import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BaseDoughnutChart extends StatelessWidget {
  final List<ChartData> data;

  const BaseDoughnutChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: SfCircularChart(
          legend: Legend(isVisible: true),
          series: <DoughnutSeries<ChartData, String>>[
            DoughnutSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelSettings: DataLabelSettings(isVisible: false), // Disable data labels
            )
          ],
        ),
      ),
    );
  }
}