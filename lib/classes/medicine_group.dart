import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroup {
  String _name;
  final List<Medicine> _medicineGroup;
  late DateTime _timestamp;
  
  MedicineGroup(this._name, this._medicineGroup) {
    _timestamp = DateTime.now();
  }
  
  MedicineGroup.withTimestamp(this._name, this._medicineGroup, this._timestamp);

  void addMedicine(Medicine medicine) {
    _medicineGroup.add(medicine);
  }

  void removeMedicine(Medicine medicine) {
    _medicineGroup.removeWhere((element) => element == medicine);
  }

  set setTimeStamp(DateTime timestamp) {
    _timestamp = timestamp;
  }

  set setName(String name) {
    _name = name;
  }

  String get getName => _name;
  List<Medicine> get getMedicineGroup => _medicineGroup;
  DateTime get getTimestamp => _timestamp;
}
