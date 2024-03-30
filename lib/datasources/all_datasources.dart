import 'dart:io';

import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';

class AllDatas {
  late List<MedicineGroup> allMedicineGroups;

  AllDatas._privateConstructor() {
    _initialize();
  }

  static final AllDatas _instance = AllDatas._privateConstructor();

  factory AllDatas() {
    return _instance;
  }

  void _initialize() {
    allMedicineGroups = fetchMedicineGroups();
  }

  List<MedicineGroup> fetchMedicineGroups() {
    // implement method here
    return [];
  }
}

class TemporaryAllDatas {
  late List<MedicineGroup> allMedicineGroups;

  TemporaryAllDatas._privateConstructor() {
    _initialize();
  }

  static final TemporaryAllDatas _instance = TemporaryAllDatas._privateConstructor();

  factory TemporaryAllDatas() {
    return _instance;
  }

  void _initialize() {
    allMedicineGroups = fetchMedicineGroups();
  }

  List<MedicineGroup> fetchMedicineGroups() {
    return [
      MedicineGroup(
        "001",
        [
          Medicine.withCount('001', 'Alprazolam', File(''), 20),
          Medicine('002', 'Meclizine', File('')),
        ]
      ),
      MedicineGroup(
        "002",
        [
          Medicine('003', 'Paracetamol', File('')),
          Medicine.withCount('004', 'Ibuprofen', File(''), 20),
        ]
      ),
      MedicineGroup(
        "003",
        [
          Medicine.withCount('005', 'Loratadine', File(''), 20),
          Medicine('006', 'Diphenhydramine', File('')),
        ]
      ),
      MedicineGroup(
        "004",
        [
          Medicine.withCount('005', 'Loratadine', File(''), 20),
          Medicine('006', 'Diphenhydramine', File('')),
        ]
      ),
    ];
  }
}
