import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:path/path.dart';

class AllDatas {
  List<MedicineGroup> allMedicineGroups = [];
  List<Medicine> allMedicines = [];

  List<Medicine> temporaryMedicinesFromCreateNewGroup = [];
  List<Medicine> temporaryMedicineFromEditGroup = [];
  String? temporaryGroupNameFromCreateNewGroup;
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

  Future<void> detectAllTemporaryCreateNewGroup() async {
    for (Medicine medicine in temporaryMedicinesFromCreateNewGroup) {
      String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/detect/';
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      var stream = http.ByteStream(Stream.castFrom(medicine.getImage.openRead()));
      var length = await medicine.getImage.length();
      var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(medicine.getImage.path));
      request.files.add(multipartFile);
      request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
      if (temporaryGroupId != null) {
        request.fields['mgid'] = temporaryGroupId!;
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        medicine.setMid = jsonDecode(responseBody)['firestore']['medicine'];
        temporaryGroupId ??= jsonDecode(responseBody)['firestore']['medicineGroup'];
        medicine.setGroupID = temporaryGroupId!;
        medicine.modifyMedicine(medicine.getName, medicine.getCount);
      } else {
        print('Failed to upload image. Error code: ${response.statusCode}');
      }
    }
  
    MedicineGroup? temp = await fetchMedicineGroup(temporaryGroupId!, temporaryGroupNameFromCreateNewGroup);
    if (temp != null) {
      allMedicineGroups.add(temp);
    }
    temporaryMedicinesFromCreateNewGroup.clear();
    temporaryGroupId = null;
    temporaryGroupNameFromCreateNewGroup = null;
  }

  Future<MedicineGroup?> fetchMedicineGroup(String mgid, String? groupName) async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_medicine_group/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    request.fields['mgid'] = mgid;
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      MedicineGroup temp = MedicineGroup.fromJson(jsonDecode(responseBody)['medicineGroup'] as Map<String, dynamic>);
      if (groupName != null) {
        temp.modifyMedicineGroup(groupName);
      }
      return temp;
    } else {
      print('Failed to fetch Medicine Group. Error code: ${response.statusCode}');
      return null;
    }
  }

  Future<void> detectAllTemporaryEditGroup(
    String mgid, String editGroupName) async {
    for (Medicine medicine in temporaryMedicineFromEditGroup) {
      String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/detect/';
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      var stream =
          http.ByteStream(Stream.castFrom(medicine.getImage.openRead()));
      var length = await medicine.getImage.length();
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(medicine.getImage.path));
      request.files.add(multipartFile);
      request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
      if (temporaryGroupId != null) {
        request.fields['mgid'] = temporaryGroupId!;
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        medicine.setMid = jsonDecode(responseBody)['firestore']['medicine'];
        temporaryGroupId ??=
            jsonDecode(responseBody)['firestore']['medicineGroup'];
        medicine.setGroupID = temporaryGroupId!;
        medicine.modifyMedicine(medicine.getName, medicine.getCount);
      } else {
        print('Failed to upload image. Error code: ${response.statusCode}');
      }
    }

    await fetchMedicineGroup(mgid, editGroupName);
    temporaryMedicineFromEditGroup.clear();
  }
}
