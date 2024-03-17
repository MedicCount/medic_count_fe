import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroup {
  final List<Medicine> _medicineGroup;
  late DateTime _timestamp;
  
  MedicineGroup(this._medicineGroup) {
    _timestamp = DateTime.now();
  }
  
  MedicineGroup.withTimestamp(this._medicineGroup, this._timestamp);

  void addMedicine(Medicine medicine) {
    _medicineGroup.add(medicine);
  }

  void removeMedicine(Medicine medicine) {
    _medicineGroup.removeWhere((element) => element == medicine);
  }

  set setTimeStamp(DateTime timestamp) {
    _timestamp = timestamp;
  }

  List<Medicine> get getMedicineGroup => _medicineGroup;
  DateTime get getTimestamp => _timestamp;
}
