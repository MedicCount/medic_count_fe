import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroup {
  late String _mgid;
  late String _name;
  late List<Medicine> _medicineGroup;
  late DateTime _timestamp;

  MedicineGroup(this._mgid, this._name, this._medicineGroup);
  
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
      DateTime.parse(json['_createdDate']),
    );
  }

  Future<void> modifyMedicineGroup(String name) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT',
      Uri.parse('${dotenv.env['BACKEND_API_URL']!}/update_medicine_group/${
        FirebaseAuth.instance.currentUser!.uid
      }/$_mgid/'));
    request.body = json.encode({
      "groupName": name,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      _name = name;
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleteMedicineGroup() async {
    var request = http.MultipartRequest('DELETE', Uri.parse('${dotenv.env['BACKEND_API_URL']!}/delete_medicine_group/'));
    request.fields.addAll({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'mgid': _mgid
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      _medicineGroup.clear;
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
