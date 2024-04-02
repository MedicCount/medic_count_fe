import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/base_doughnutChart.dart';
import 'package:medic_count_fe/components/base_lineChart.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    List<MedicineGroup> allMedicineGroups = AllDatas().allMedicineGroups;
    List<Medicine> allMedicines = AllDatas().allMedicines;

    Map<String, MapEntry<String, int>> eachGroupCount = {};

    for (MedicineGroup mg in allMedicineGroups) {
      for (Medicine m in allMedicines) {
        if (m.getGroupId == mg.getMgid) {
          if (eachGroupCount.containsKey(mg.getMgid)) {
            eachGroupCount[mg.getMgid] = MapEntry(
              mg.getName,
              eachGroupCount[mg.getMgid]!.value + m.getCount,
            );
          } else {
            eachGroupCount[mg.getMgid] = MapEntry(mg.getName, m.getCount);
          }
        }
      }
    }

    // set default value for dropdown
    String selectedGroup = "I4Ef4jWI73WwYm3GgUTC";
    Map<String, int> eachMedicineCount = {};

    for (Medicine m in allMedicines) {
      if (m.getGroupId == selectedGroup) {
        if (eachMedicineCount.containsKey(m.getName)) {
          eachMedicineCount[m.getName] = eachMedicineCount[m.getName]! + m.getCount;
        } else {
          eachMedicineCount[m.getName] = m.getCount;
        }
      }
    }


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
                    child: BaseLineChart(
                        data: eachGroupCount.entries
                            .map((e) => ChartData(
                                e.value.key + ' (${e.value.value})',
                                e.value.value))
                            .toList()))),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 2,
              ),
            ),
            Row(
              children: [
                
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
                        child: BaseDoughnutChart(data: eachMedicineCount.entries
                            .map((e) => ChartData(
                                e.key,
                                e.value))
                            .toList())))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                  (index) => Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        width: 160,
                        child: Card(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('$index'),
                                  ],
                                ),
                                Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.image),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        width: 50,
                                        child:
                                            const Expanded(child: Text('1000')))
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
