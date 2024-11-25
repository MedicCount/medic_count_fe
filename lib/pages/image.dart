import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/components/buttons.dart';

class ShowImage extends StatefulWidget {
  final File image;
  final List<Medicine> medicines;
  final Function reloadPage;
  final String? mgid;

  const ShowImage(
    {Key? key,
    required this.image,
    required this.medicines,
    required this.reloadPage,
    this.mgid})
    : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  late File _croppedImage;
  late Medicine medicine;

  @override
  void initState() {
    medicine = Medicine("", "", "", File(""));
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

  @override
  Widget build(BuildContext context) {
    void addMedicineInGroup() {
      TextEditingController medicineNameController = TextEditingController();

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
            height: MediaQuery.of(context).size.height / 8,
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
                  ],
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
                    final Medicine medicine = Medicine(
                      "unknown",
                      widget.mgid != null ? widget.mgid! : "unknown",
                      medicineNameController.text,
                      widget.image,
                    );
                    widget.medicines.add(medicine);
                    widget.reloadPage();
                    for (int i = 0; i < 3; i++) {
                      Navigator.of(context).pop();
                    }
                  },
                  label: 'Confirm',
                ),
                const SizedBox(width: 20),
                SecondaryButton(
                  function: () {
                    for (int i = 0; i < 3; i++) {
                      Navigator.of(context).pop();
                    }
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              child: Image.file(
                _croppedImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: BaseButton(
                      function: () async {
                        addMedicineInGroup();
                      },
                      label: 'Save',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SecondaryButton(
                      function: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      label: 'Cancel',
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
