import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BaseLineChart extends StatelessWidget {
  final List<ChartData> data;

  const BaseLineChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: SfCartesianChart(
          legend: const Legend(isVisible: true),
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              isVisibleInLegend: false,
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
            )
          ],
        ),
      ),
    );
  }
}