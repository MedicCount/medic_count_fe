import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/base_doughnut_chart.dart';
import 'package:medic_count_fe/components/base_line_chart.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  late String _selectedGroup = '';
  late List<MedicineGroup> allMedicineGroups;
  late List<Medicine> allMedicines;

  @override
  void initState() {
    super.initState();
    allMedicineGroups = AllDatas().allMedicineGroups;
    allMedicines = AllDatas().allMedicines;
    if (allMedicineGroups.isNotEmpty) {
      _selectedGroup = allMedicineGroups[0].getMgid;
    }
  }

  @override
  Widget build(BuildContext context) {
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

    Map<String, int> eachMedicineCount = {};
    int totalCounts = 0;
    for (Medicine m in allMedicines) {
      if (m.getGroupId == _selectedGroup) {
        totalCounts += m.getCount;
        if (eachMedicineCount.containsKey(m.getName)) {
          eachMedicineCount[m.getName] =
              eachMedicineCount[m.getName]! + m.getCount;
        } else {
          eachMedicineCount[m.getName] = m.getCount;
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Medicines',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButton<String>(
                        value: _selectedGroup,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGroup = newValue!;
                          });
                        },
                        items: allMedicineGroups.map<DropdownMenuItem<String>>(
                          (MedicineGroup group) {
                            return DropdownMenuItem<String>(
                              value: group.getMgid,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  group.getName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: BaseDoughnutChart(
                      data: eachMedicineCount.entries
                        .map((e) => ChartData(e.key, e.value, totalCounts))
                        .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Total Medicines',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 250,
                    child: BaseLineChart(
                      data: eachGroupCount.entries
                        .map(
                          (e) => ChartData(
                            '${e.value.key} (${e.value.value})',
                            e.value.value,
                            totalCounts
                          ),
                        )
                        .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
