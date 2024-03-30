import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/medicine_group_display.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class CountedPage extends StatefulWidget {
  const CountedPage({Key? key}) : super(key: key);

  @override
  State<CountedPage> createState() => _CountedPageState();
}

class _CountedPageState extends State<CountedPage> {
  final List<MedicineGroup> medicineGroups = TemporaryAllDatas().allMedicineGroups;
  final int numberOfMedicineGroups = 3;
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Text('Sort by'),
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 2.75,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: DropdownButton(
                  items: <String>['Ascending', 'Descending']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  value: _selectedValue,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(numberOfMedicineGroups, (index) {
                  MedicineGroup temp = medicineGroups[index];
                  return MedicineGroupDisplay(
                    groupName: temp.getName,
                    timeCreated: temp.getTimestamp,
                    medicineGroup: temp.getMedicineGroup,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
