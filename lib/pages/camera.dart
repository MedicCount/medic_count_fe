import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/components/buttons.dart';
import 'package:medic_count_fe/pages/image.dart';

class Camera extends StatefulWidget {
  final String? mgid;
  List<Medicine> medicines;
  Function reloadPage;

  Camera({
    Key? key,
    this.mgid,
    required this.medicines,
    required this.reloadPage,
  }) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras;
  late CameraImage cameraImage;
  CameraController? controller;
  final picker = ImagePicker();
  late TextEditingController medicineNameController;
  late TextEditingController medicineTotalCountController;

  @override
  void initState() {
    loadCamera();
    super.initState();
    medicineNameController = TextEditingController();
    medicineTotalCountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    medicineNameController.dispose();
    medicineTotalCountController.dispose();
  }

  void loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.high);
      await controller!.initialize();
      setState(() {});
    } else {
      throw Exception("No Camera Found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToProcessImage(XFile image) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowImage(
        image: File(image.path),
        medicines: widget.medicines,
        reloadPage: widget.reloadPage,
        mgid: widget.mgid,
      )));
    }

    Future<void> getImageFromGallery() async {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        navigateToProcessImage(pickedFile);
      }
    }

    Future<void> getImageFromCamera() async {
      final XFile pickedFile = await controller!.takePicture();
      navigateToProcessImage(pickedFile);
      print(pickedFile);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Camera",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Make the camera area fit the tray and use it with the same type of medicine only",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Stack(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: controller == null || !controller!.value.isInitialized
                          ? const Center(child: Text("Loading Camera..."))
                          : CameraPreview(controller!),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: BaseButton(
                      function: getImageFromCamera,
                      label: 'Capture',
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
                      function: getImageFromGallery,
                      label: 'Use Local',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
