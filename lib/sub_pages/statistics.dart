import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medic_count_fe/components/base_dropdown.dart';
import 'package:medic_count_fe/components/base_lineChart.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BaseDropdown(list: ['Group 1', 'Group 2', 'Group 3']),
        SizedBox(height: 250, child: Expanded(child: BaseLineChart())),
      ],
    ));
  }
}
