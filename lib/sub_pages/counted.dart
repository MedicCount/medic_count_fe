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
  final List<String> sortOptions = ['Name', 'Date Created'];
  String _selectedValue = 'Name';

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
            children: <Widget>[
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: sortOptions.map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedValue = option;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedValue == option ? Theme.of(context).primaryColor : Colors.grey[90],
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: _selectedValue == option ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Scrollbar(
              thickness: 5,
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(medicineGroups.length, (index) {
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
            ),
          ),
        ],
      ),
    );
  }
}
