import 'package:flutter/material.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/medicine_group_display.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class CountedPage extends StatefulWidget {
  const CountedPage({Key? key}) : super(key: key);

  @override
  State<CountedPage> createState() => _CountedPageState();
}

class _CountedPageState extends State<CountedPage> {
  late List<MedicineGroup> allMedicineGroups;
  List<MedicineGroup> filteredMedicineGroups = [];
  final List<String> sortOptions = ['Name', 'Date Created'];
  late String _selectedValue;
  late String _selectedOrder;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allMedicineGroups = AllDatas().allMedicineGroups;
    _selectedValue = sortOptions[0];
    _selectedOrder = 'Ascending';
    filteredMedicineGroups.addAll(allMedicineGroups);
  }

  void reloadPage() {
    setState(() {});
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<MedicineGroup> dummyListData = [];
      for (MedicineGroup medicineGroup in allMedicineGroups) {
        if (medicineGroup.getName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(medicineGroup);
        }
        for (Medicine medicine in medicineGroup.getMedicineGroup) {
          if (medicine.getName.toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(medicineGroup);
            break;
          }
        }
      }
      setState(() {
        filteredMedicineGroups.clear();
        filteredMedicineGroups.addAll(dummyListData);
      });
    } else {
      setState(() {
        filteredMedicineGroups.clear();
        filteredMedicineGroups.addAll(allMedicineGroups);
      });
    }
  }

  void sortMedicineGroups() {
    setState(() {
      if (_selectedValue == 'Name') {
        filteredMedicineGroups.sort((a, b) => a.getName.compareTo(b.getName));
      } else if (_selectedValue == 'Date Created') {
        filteredMedicineGroups
            .sort((a, b) => a.getTimestamp.compareTo(b.getTimestamp));
      }

      if (_selectedOrder == 'Descending') {
        filteredMedicineGroups = filteredMedicineGroups.reversed.toList();
      }
    });
  }

  void handleDelete(MedicineGroup deletedGroup) {
    setState(() {
      allMedicineGroups.removeWhere((group) => group == deletedGroup);
      filteredMedicineGroups.removeWhere((group) => group == deletedGroup);
    });
    deletedGroup.deleteMedicineGroup();
  }

  void handleUpdate(MedicineGroup editGroup) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(value.trim());
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Sort by',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue!;
                      sortMedicineGroups();
                    });
                  },
                  items:
                      sortOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedOrder,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOrder = newValue!;
                      sortMedicineGroups();
                    });
                  },
                  items: ['Ascending', 'Descending']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                      children:
                          List.generate(filteredMedicineGroups.length, (index) {
                        MedicineGroup temp = filteredMedicineGroups[index];
                        return MedicineGroupDisplay(
                          groupName: temp.getName,
                          timeCreated: temp.getTimestamp,
                          medicineGroup: temp,
                          onDelete: () => handleDelete(temp),
                          onUpdate: () => handleUpdate(temp),
                          reloadPage: reloadPage,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
