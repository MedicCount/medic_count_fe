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
    allMedicineGroups.addAll(
      [
        MedicineGroup(
          [
            Medicine(
              '001',
              'Alprazolam',
              File(''),
            ),
            Medicine(
              '002',
              'Meclizine',
              File(''),
            ),
          ],
        ),
        MedicineGroup(
          [
            Medicine(
              '001',
              'Alprazolam',
              File(''),
            ),
            Medicine(
              '002',
              'Meclizine',
              File(''),
            ),
          ],
        ),
        MedicineGroup(
          [
            Medicine(
              '001',
              'Alprazolam',
              File(''),
            ),
            Medicine(
              '002',
              'Meclizine',
              File(''),
            ),
          ],
        ),
      ]
    );
  }
}
