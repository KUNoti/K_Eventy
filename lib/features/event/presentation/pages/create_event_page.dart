import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  XFile? pickedFile;
  // ImageUploadService uploadService = ImageUploadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: Center(
        child: Column(
          children: [
            Visibility(
              visible: pickedFile != null,
              child: pickedFile != null
                ? Image.file(File(pickedFile!.path), height: 200, width: 200,)
                : Container()
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _checkPermissions();
                },
                child: const Text("Selected Image")
            )
          ],
        ),
      ),
    );
  }

  Future _checkPermissions() async {

    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (status[Permission.camera] != PermissionStatus.granted ||
        status[Permission.camera] != PermissionStatus.granted) {
      return;
    }

    _pickImage();
  }

  Future _pickImage() async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // uploadService.uploadImage(pickedFile);
    setState(() { });
  }

}
