import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/chart_data.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/base_doughnutChart.dart';
import 'package:medic_count_fe/components/base_lineChart.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  String? _selectedGroup;
  late List<MedicineGroup> allMedicineGroups;
  late List<Medicine> allMedicines;

  @override
  void initState() {
    super.initState();
    allMedicineGroups = AllDatas().allMedicineGroups;
    allMedicines = AllDatas().allMedicines;
    if (!allMedicineGroups.isEmpty) {
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

    // set default value for dropdown
    Map<String, int> eachMedicineCount = {};
    if (allMedicines.isEmpty) {
      for (Medicine m in allMedicines) {
        if (m.getGroupId == _selectedGroup) {
          if (eachMedicineCount.containsKey(m.getName)) {
            eachMedicineCount[m.getName] =
                eachMedicineCount[m.getName]! + m.getCount;
          } else {
            eachMedicineCount[m.getName] = m.getCount;
          }
        }
      }
    }

    Widget medicineCard(String name, int counts) {
      return Container(
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
                      Text('$name'),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.image),
                      Container(
                        alignment: Alignment.centerRight,
                        width: 50,
                        child: Text('$counts'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
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
                  title: const Text(
                    "OVERALL :))",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "number of each group",
                    style: TextStyle(fontSize: 15, color: Colors.grey[300]),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: BaseLineChart(
                  data: eachGroupCount.entries
                      .map(
                        (e) => ChartData(
                          e.value.key + ' (${e.value.value})',
                          e.value.value,
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 2,
                ),
              ),
              Row(
                children: [
                  DropdownButton<String>(
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
                          child: Text(group.getName),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: SizedBox(
                  height: 200,
                  child: BaseDoughnutChart(
                    data: eachMedicineCount.entries
                        .map((e) => ChartData(e.key, e.value))
                        .toList(),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: eachMedicineCount.entries
                      .map((e) => medicineCard(e.key, e.value))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
