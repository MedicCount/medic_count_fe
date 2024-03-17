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
