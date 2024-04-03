import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Medicine {
  late String _mid;
  String _groupId;
  String _name;
  File? _image;
  late int _counts;
  List<dynamic> labels = [];

  Medicine(this._mid, this._groupId, this._name, this._image) {
    _counts = 0;
  }

  Medicine.withCount(this._mid, this._groupId, this._name, this._image, this._counts);

  Medicine.withCountwithLabel(this._mid, this._groupId, this._name, this._image, this._counts, this.labels);

  void increaseCount(int amount) {
    _counts += amount;
  }

  void decreaseCount(int amount) {
    _counts -= amount;
  }
  
  set setName(String name) {
    _name = name;
  }

  set setImage(File image) {
    _image = image;
  }

  set setCount(int counts) {
    _counts = counts;
  }

  set setMid(String mid) {
    _mid = mid;
  }

  set setGroupID(String groupId) {
    _groupId = groupId;
  }

  String get getGroupId => _groupId;
  String get getName => _name;
  File get getImage => _image!;
  int get getCount => _counts;
  List<dynamic> get getLabels => labels;
  String get getMid => _mid;

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine.withCountwithLabel(
      json['_mid'],
      json['groupId'],
      json['name'],
      File(json['_image']),
      json['counts'],
      json['labels'],
    );
  }

  Future<Uint8List?> fetchImage() async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_image/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields.addAll({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'mid': _mid
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.toBytes();
    } else {
      print(response.reasonPhrase);
      return Uint8List.fromList(_image!.readAsBytesSync());
    }
  }

  Future<void> modifyMedicine(String name, int count) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT',
      Uri.parse('${dotenv.env['BACKEND_API_URL']!}/update_medicine/${
        FirebaseAuth.instance.currentUser!.uid
      }/$_mid/'));
    request.body = json.encode({
      "counts": count,
      "name": name,
      "groupId": _groupId,
      "lables": labels,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      _name = name;
      _counts = count;
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleteMedicine() async {
    var request = http.MultipartRequest('DELETE', Uri.parse('${dotenv.env['BACKEND_API_URL']!}/delete_medicine/'));
    request.fields.addAll({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'mid': _mid
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<int> fetchMedicine(Medicine medicine, String mid) async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_medicine/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    request.fields['mid'] = mid;
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Medicine fetch successfully');
      return jsonDecode(responseBody)['medicine']['counts'];
    } else {
      print('Failed to fetch medicine. Error code: ${response.statusCode}');
      return 0;
    }
  }
}
