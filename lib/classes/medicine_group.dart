import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroup {
  late String _mgid;
  late String _name;
  late List<Medicine> _medicineGroup;
  late DateTime _timestamp;
  
  MedicineGroup(this._mgid, this._name, this._medicineGroup) {
    _timestamp = DateTime.now();
  }
  
  MedicineGroup.withTimestamp(this._mgid, this._name, this._medicineGroup, this._timestamp);

  MedicineGroup.clone(MedicineGroup source) {
    copy(source);
  }

  void copy(MedicineGroup source) {
    _mgid = source._mgid;
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

  String get getMgid => _mgid;
  String get getName => _name;
  List<Medicine> get getMedicineGroup => _medicineGroup;
  DateTime get getTimestamp => _timestamp;

  factory MedicineGroup.fromJson(Map<String, dynamic> json) {
    return MedicineGroup.withTimestamp(
      json['_mgid'],
      json['groupName'],
      [],
      DateTime.parse(json['createdDate']),
    );
  }
}
