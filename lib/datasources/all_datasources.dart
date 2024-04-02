import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';

class AllDatas {
  List<MedicineGroup> allMedicineGroups = [];
  List<Medicine> allMedicines = [];

  List<Medicine> temporaryMedicinesFromCreateNewGroup = [];
  List<Medicine> temporaryMedicineFromEditGroup = [];
  late String temporaryGroupName;
  String? temporaryGroupId;

  AllDatas._privateConstructor();

  static final AllDatas _instance = AllDatas._privateConstructor();

  factory AllDatas() {
    return _instance;
  }

  Future<void> fetchAllData() async {
    allMedicineGroups.clear();
    allMedicines.clear();

    await fetchAllMedicineGroups();
    await fetchAllMedicines();

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

  set setTemporaryGroupName(String temporaryGroupName) {
    this.temporaryGroupName = temporaryGroupName;
  }
}
