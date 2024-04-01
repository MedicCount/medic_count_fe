import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';

class AllDatas {
  List<MedicineGroup> allMedicineGroups = [];
  List<Medicine> allMedicines = [];

  AllDatas._privateConstructor() {
    fetchAllData();
  }

  static final AllDatas _instance = AllDatas._privateConstructor();

  factory AllDatas() {
    return _instance;
  }

  Future<void> fetchAllData() async {
    fetchAllMedicineGroups();
    fetchAllMedicines();

    for (MedicineGroup medicineGroup in allMedicineGroups) {
      for (Medicine medicine in allMedicines) {
        if (medicine.getGroupId == medicineGroup.getMgid) {
          medicineGroup.addMedicine(medicine);
        }
      }
    }
  }

  Future<void> fetchAllMedicineGroups() async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_all_medicine_groups/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      for (dynamic object in jsonDecode(responseBody)['medicineGroupList']) {
        allMedicineGroups.add(MedicineGroup.fromJson(object as Map<String, dynamic>));
      }
      print('Medicine groups fetch successfully');
    } else {
      print('Failed to fetch medicine groups. Error code: ${response.statusCode}');
    }
  }

  Future<void> fetchAllMedicines() async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_all_medicines/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      for (dynamic object in jsonDecode(responseBody)['medicineList']) {
        allMedicines.add(Medicine.fromJson(object as Map<String, dynamic>));
      }
      print('Medicine fetch successfully');
    } else {
      print('Failed to fetch medicine. Error code: ${response.statusCode}');
    }
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
        "Name1",
        [
          Medicine.withCount('001', 'Alprazolam', File(''), 20),
          Medicine('002', 'Meclizine', File('')),
        ]
      ),
      MedicineGroup(
        "002",
        "Name2",
        [
          Medicine('003', 'Paracetamol', File('')),
          Medicine.withCount('004', 'Ibuprofen', File(''), 20),
        ]
      ),
      MedicineGroup(
        "003",
        "Name3",
        [
          Medicine.withCount('005', 'Loratadine', File(''), 20),
          Medicine('006', 'Diphenhydramine', File('')),
        ]
      ),
      MedicineGroup(
        "004",
        "Name4",
        [
          Medicine.withCount('005', 'Loratadine', File(''), 20),
          Medicine('006', 'Diphenhydramine', File('')),
        ]
      ),
    ];
  }
}
