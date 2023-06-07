import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  File? _image;

  final imagePicker = ImagePicker();
  void getImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Admin Page'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      getImage;
                    },
                    
                    // child: Container(
                    //   width: 200,
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: _image != null
                    //               ? FileImage(_image!) as ImageProvider
                    //               : const AssetImage('assets/images/Logo.png'),
                    //           fit: BoxFit.cover),
                    //       color: Colors.amber),
                    // ),
                  ),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
