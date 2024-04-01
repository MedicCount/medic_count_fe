import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ProcessImage extends StatefulWidget {
  final File image;

  const ProcessImage({Key? key, required this.image}) : super(key: key);

  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  late File _croppedImage;

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
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    // if (croppedFile != null) {
    //     _croppedImage = croppedFile;
    //     setState(() { });
    // } else {
    //   print("Image is not cropped.");
    // }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Image.file(_croppedImage),
      ),
    );
  }
}
