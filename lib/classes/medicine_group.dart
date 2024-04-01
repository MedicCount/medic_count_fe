import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroup {
  late String _name;
  late List<Medicine> _medicineGroup;
  late DateTime _timestamp;
  
  MedicineGroup(this._name, this._medicineGroup) {
    _timestamp = DateTime.now();
  }
  
  MedicineGroup.withTimestamp(this._name, this._medicineGroup, this._timestamp);

  MedicineGroup.clone(MedicineGroup source) {
    copy(source);
  }

  void copy(MedicineGroup source) {
    _name = source._name;
    _medicineGroup = List.from(source._medicineGroup);
    _timestamp = source._timestamp;
  }

  void addMedicine(Medicine medicine) {
    _medicineGroup.add(medicine);
  }

  void removeMedicine(Medicine medicine) {
    _medicineGroup.removeWhere((element) => element == medicine);
  }

  void deleteAllMedicineAndGroup() {
    _medicineGroup.clear();
  }

  set setTimeStamp(DateTime timestamp) {
    _timestamp = timestamp;
  }

  set setName(String name) {
    _name = name;
  }

  set setMedicineGroup(MedicineGroup medicineGroup) {
    _medicineGroup = medicineGroup.getMedicineGroup;
  }

  String get getName => _name;
  List<Medicine> get getMedicineGroup => _medicineGroup;
  DateTime get getTimestamp => _timestamp;
}
