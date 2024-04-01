import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/components/buttons.dart';
import 'package:medic_count_fe/pages/home.dart';
import 'package:path/path.dart';

class ProcessImage extends StatefulWidget {
  final File image;
  final String? mgid;

  const ProcessImage({Key? key, required this.image, this.mgid}) : super(key: key);

  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  late String mid;
  late final String mgid;

  late File _croppedImage;
  late Medicine medicine;

  @override
  void initState() {
    super.initState();
    _croppedImage = widget.image;
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _croppedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: const Color(0xFF8000FF),
          activeControlsWidgetColor: const Color(0xFF8000FF),
          statusBarColor: const Color(0xFF8000FF),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = File(croppedFile.path);
      });
    } else {
      print("Image is not cropped.");
    }
  }

  Future<void> _sendImage() async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/detect/';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    var stream = http.ByteStream(Stream.castFrom(_croppedImage.openRead()));
    var length = await _croppedImage.length();
    var multipartFile = http.MultipartFile('file', stream, length, filename: basename(_croppedImage.path));
    request.files.add(multipartFile);
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    if (widget.mgid != null) {
      request.fields['mgid'] = mgid;
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      mid = jsonDecode(responseBody)['firestore']['medicine'];
      if (widget.mgid == null) {
        mgid = jsonDecode(responseBody)['firestore']['medicineGroup'];
      }
    } else {
      print('Failed to upload image. Error code: ${response.statusCode}');
    }
  }

  Future<void> _getCurrentMedicine() async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/get_medicine/';
    var request = http.MultipartRequest('GET', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    request.fields['mid'] = "0P9ZMDwDMufNaT3Ohoor";
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      medicine = Medicine.fromJson(jsonDecode(responseBody)['medicine'] as Map<String, dynamic>);
      print('Medicine fetch successfully');
    } else {
      print('Failed to fetch medicine groups. Error code: ${response.statusCode}');
    }
  }

  Future<void> _modifyToGroup(String name, int counts) async {
    String apiUrl = '${dotenv.env['BACKEND_API_URL']!}/update_medicine/';
    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    request.fields['mid'] = mid;

    Map<String, dynamic> jsonPayload = {
      "counts": counts,
      "name": name,
      "groupId": medicine.getGroupId,
      "labels": medicine.getLabels,
    };

    request.fields['jsonPayload'] = jsonEncode(jsonPayload);
    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      print('Failed to upload image. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    void addMedicineInGroup() {
      TextEditingController medicineNameController = TextEditingController();
      TextEditingController medicineTotalCountController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Modify Medicine',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 4.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Medicine Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: medicineNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter medicine name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Total Counts',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: medicineTotalCountController..text = medicine.getCount.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter total counts',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseButton(
                  function: () {
                    _modifyToGroup(
                      medicineNameController.text.trim(),
                      int.parse(medicineTotalCountController.text.trim()),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      ModalRoute.withName('/home'),
                    );
                  },
                  label: 'Confirm',
                ),
                const SizedBox(width: 20),
                SecondaryButton(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Cancel',
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Processed Image',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _cropImage,
            icon: const Icon(Icons.crop),
          ),
          IconButton(
            onPressed: () async {
              await _sendImage();
              await _getCurrentMedicine();
              addMedicineInGroup();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Image.file(_croppedImage),
        ),
      ),
    );
  }
}
