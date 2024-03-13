import 'package:flutter/material.dart';

class ProcessImage extends StatefulWidget {
  const ProcessImage({Key? key}) : super(key: key);

  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processed Image'),
      ),
      body: Center(
        // child: loading
        //     ? const CircularProgressIndicator()
        //     : Image.file(image),
      ),
    );
  }
}
