import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';

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
    const String apiUrl = 'https://homeless-incorrect-q-donated.trycloudflare.com/detect/';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    var stream = http.ByteStream(Stream.castFrom(_croppedImage.openRead()));
    var length = await _croppedImage.length();
    var multipartFile = http.MultipartFile('file', stream, length, filename: basename(_croppedImage.path));
    request.files.add(multipartFile);
    request.fields['uid'] = FirebaseAuth.instance.currentUser!.uid;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Error code: ${response.statusCode}');
    }
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
          IconButton(
            onPressed: _sendImage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Center(
        child: Image.file(_croppedImage),
      ),
    );
  }
}
