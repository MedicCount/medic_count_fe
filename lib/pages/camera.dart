import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medic_count_fe/components/buttons.dart';
import 'package:medic_count_fe/pages/process_image.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras;
  late CameraImage cameraImage;
  CameraController? controller;

  final picker = ImagePicker();

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
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

  void navigateToProcessImage(XFile image) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProcessImage(image: File(image.path))));
  }

  @override
  Widget build(BuildContext context) {
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
