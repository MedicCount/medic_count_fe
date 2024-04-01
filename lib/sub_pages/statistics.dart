import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:medic_count_fe/components/base_doughnutChart.dart';
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
    return Center(
        child: Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                title: const Text("OVERALL :))",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                subtitle: Text("number of each group",
                    style: TextStyle(fontSize: 15, color: Colors.grey[300])),
              ),
            ),
            SizedBox(
                height: 250,
                child: Expanded(
                    child: BaseLineChart(data: [
                  ChartData('A', 10),
                  ChartData('B', 14),
                  ChartData('C', 6),
                  ChartData('D', 20),
                ]))),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 2,
              ),
            ),
            const Row(
              children: [
                BaseDropdown(list: ['Group 1', 'Group 2', 'Group 3']),
              ],
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: SizedBox(
                    height: 200,
                    child: Expanded(
                        child: BaseDoughnutChart(data: [
                      ChartData('A', 25),
                      ChartData('B', 25),
                      ChartData('C', 25),
                      ChartData('D', 25),
                    ])))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => 
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      width: 160,
                      child: Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Group $index'),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.primary,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.image),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 50,
                                    child: Expanded(child: Text('1000')))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
